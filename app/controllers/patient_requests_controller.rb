class PatientRequestsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Layout para el terapeuta
	layout "therapist", :only => [ :lue, :new, :edit ]

	# GET
	def lue

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

		# Nos quedamos solo con los que tienen status esperando o contactado
		@patient_requests.keep_if { | pat_req |
			pat_req.patient.status == "waiting" or pat_req.patient.status == "contacted"
		}

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
		AffectedArea::AFFECTED_AREAS.each do | area_name |
			@patient_request.affected_areas.build
			@patient_request.affected_areas.last.area = area_name
		end
		
		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 1
	end

	# GET
	def edit

		# Obtenemos la solicitud
		@patient_request = PatientRequest.find(params[:id])

		# Areas afectadas
		affected_areas = @patient_request.affected_areas
		AffectedArea::AFFECTED_AREAS.each do | area_name |

			# Vemos si tiene esta area
			has_area = false
			affected_areas.each do | a_area |
				if (a_area.area == area_name) or (a_area.isOther? and area_name == "Otro")
					has_area = true
					break
				end
			end

			if not has_area
				@patient_request.affected_areas.build
				@patient_request.affected_areas.last.area = area_name
			end
		end

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 1

		render template: "patient_requests/new"
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

				# Estado en espera
				@patient.status = "waiting"

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

	# PATCH
	def update

		# Obtenemos los objetos
		@patient = Patient.find_by_account_number( params[:patient][:account_number] )
		@patient_request = @patient.patient_request

		# Limpiamos las areas afectadas vacias
		aff_areas_attr = params[:patient_request][:affected_areas_attributes]
		aff_areas_attr.reject! do | key, value |
			aff_areas_attr[key]["area"] == ""
		end

		# Creamos la solicitd del paciente y checamos la validez
		@patient_request.assign_attributes(patient_requets_params)
		if @patient_request.valid?

			# Creamos al paciente solicitante y checamos la validez
			@patient.assign_attributes(patient_params)
			if @patient.valid?

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

	# DELETE
	def delete
		@patient_request = PatientRequest.find(params[:id])
		@patient = @patient_request.patient

		@patient.destroy
		@patient_request.destroy

		redirect_to lue_index_path
	end

	# GET
	def assign

		# Obtenemos el paciente
		@patient = Patient.find(params[:id])

		# Crea un expediente
		@patient_record = PatientRecord.new

		# Lo asignamos al paciente
		@patient_record.patient = @patient

		# El terapeuta que lo atendio
		@patient_record.therapist = current_therapist

		# Marcamos la fecha de hoy como la fecha de atencion
		@patient.patient_request.update_attributes(:attention_date => Time.now)

		# Le construimos los rasgos de los padres
		@patient_record.paternal_traits.build
		@patient_record.paternal_traits.last.from_mother = true

		@patient_record.paternal_traits.build
		@patient_record.paternal_traits.last.from_mother = false

		# Salvamos el expediente
		@patient_record.save

		# Marcamos al paciente como en atencion
		@patient.update_attributes(:status => "treatment")

		# Guardamos que estamos trabajando con el y enviamos al havad
		session[:current_patient] = @patient.id
		redirect_to havad_index_path
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