class PatientRequestsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Layout para el terapeuta
	layout "therapist", :only => [ :lue, :new ]

	# GET
	def lue

		# Debug
		ap params

		# El Array que se ira llenando
		@patient_requests = Array.new

		# Nos pasaron un numero de cuenta?
		if not params[:account_number].nil?

			# Buscamos un paciente con el numero de cuenta y regresamos
			patient = Patient.find_by_account_number(params[:account_number])
			@patient_requests.concat([ patient.patient_request ])

		end

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] == ""

				# Viene vacio, entonces mandamos todas
				@patient_requests = PatientRequest.all
				
			else

				# BUSQUEDA

				# Por apellido paterno
				patients_found = Patient.where("p_last_name LIKE ?", "%#{params[:searchStr]}%")

				# Por apellido materno
				patients_found += Patient.where("m_last_name LIKE ?", "%#{params[:searchStr]}%")

				# Por nombres
				patients_found += Patient.where("names LIKE ?", "%#{params[:searchStr]}%")

				# Por numero de cuenta
				patients_found += Patient.where("account_number LIKE ?", "%#{params[:searchStr]}%")

				# Agregamos todas las solicitudes de los pacientes
				patients_found.each do | patient |
					@patient_requests.concat([ patient.patient_request ])
				end
			end
		end

		# Si no hubo ninguno hay que solicitar todos
		if params[:account_number].nil? and params[:searchStr].nil?
			@patient_requests = PatientRequest.all
		end

		# Hay que filtrar
		if not params[:filter_by].nil?
			if params[:filter_by] == "schedule"
			end
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @patient_requests.size > 0
			if params[:order_by] == "condition"
				@patient_requests.sort! { |x, y|
					PatientRequest::CONDITION_ORDER[x.condition] <=> PatientRequest::CONDITION_ORDER[y.condition]
				}

			elsif params[:order_by] == "status"
				# TODO Ordenar por status del paciente

			else
				@patient_requests.sort! { |x, y|
					x.patient.attributes[params[:order_by]] <=> y.patient.attributes[params[:order_by]]
				}
			end
		end

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 0

	end

	# GET
	def new

		# Creamos los objetos
		@patient_request = PatientRequest.new
		@patient_request.patient = Patient.new

		# Areas afectadas
		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Escolar"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Familiar"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Social"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Laboral"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Pareja"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Sexual"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Emocional"

		@patient_request.affected_areas.build
		@patient_request.affected_areas.last.area = "Otro"

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 1
	end

	# POST
	def create

		# Limpiamos las areas afectadas vacias
		aff_areas_attr = params[:patient_request][:affected_areas_attributes]
		aff_areas_attr.reject! do | key, value |
			aff_areas_attr[key]["area"] == ""
		end

		# Creamos la solicitd del paciente y checamos la validez
		@patient_request = PatientRequest.new(patient_requets_params)
		if @patient_request.valid?

			# Creamos al paciente solicitante y checamos la validez
			@patient = Patient.new(patient_params)
			if @patient.valid?

				# Asignamos el paciente
				@patient_request.patient = @patient

				# Asignamos el terapeuta actual como el que recibio la solicitud
				@patient_request.receive_therapist = current_therapist

				# Dar la fecha de registro
				@patient_request.request_date = Time.now

				# Calculamos la edad del paciente
				@patient.age = age(@patient.birth)

				# Salvamos en la BD
				@patient_request.save

				# Mandamos a renderear de nuevo con mensaje
				flash[:notice] = "¡Ha registrado exitosamente un paciente!"
				puts "aca pasa"

				redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
			else
				render :new
			end
		else
			render :new
		end
	end

	private

		def patient_requets_params
			params.require(:patient_request).permit(:reasons, :condition, :how_met, :money, :pre_care,
				:affected_areas_attributes => [ :area ], :request_schedules_attributes => [ :day, :beginH, :endH ])
		end

		def patient_params
			params.require(:patient).permit(:names, :p_last_name, :m_last_name, :birth, :age, :sex, :account_number, :career,
				:init_school, :semester, :failed_subjects, :telephone1, :telephone2, :email)
		end
	
end