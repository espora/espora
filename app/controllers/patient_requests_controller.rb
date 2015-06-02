class PatientRequestsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :lue, :new, :edit, :create, :update ]

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
				@patient_requests.concat(PatientRequest.joins(:patient).where("p_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por apellido materno
				@patient_requests.concat(PatientRequest.joins(:patient).where("m_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por nombres
				@patient_requests.concat(PatientRequest.joins(:patient).where("names LIKE ?", "%#{params[:searchStr]}%"))

				# Por numero de cuenta
				@patient_requests.concat(PatientRequest.joins(:patient).where("account_number LIKE ?", "%#{params[:searchStr]}%"))

				# Eliminamos repetidos
				@patient_requests.uniq!
			end
		end

		# Si no hubo ninguno hay que solicitar todos
		if params[:account_number].nil? and params[:searchStr].nil?
			@patient_requests = PatientRequest.all
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @patient_requests.size > 0
			if params[:order_by] == "condition"
				@patient_requests.sort! { |x, y|
					PatientRequest::CONDITION_ORDER[x.condition] <=> PatientRequest::CONDITION_ORDER[y.condition]
				}

			elsif params[:order_by] == "status"
				@patient_requests.sort! { |x, y|
					Patient::STATUS_ORDER[x.patient.status] <=> Patient::STATUS_ORDER[y.patient.status]
				}

			else
				@patient_requests.sort! { |x, y|
					x.patient.attributes[params[:order_by]] <=> y.patient.attributes[params[:order_by]]
				}
			end
		end

		# Hay que filtrar
		if not params[:filter_by].nil?

			# Nos quedamos solo los que coinciden en horario con el 
			# terapeuta
			if params[:filter_by] == "schedule"
				@patient_requests.keep_if { | pat_req |
					current_therapist.match_schedule?(pat_req)
				}
			end
		end

		# Nos quedamos solo con los que tienen status esperando o contactado
		@patient_requests.keep_if { | pat_req |
			pat_req.patient.status == "uncontacted" or pat_req.patient.status == "waiting" or pat_req.patient.status == "contacted"
		}
	end

	# GET
	def new

		# Creamos los objetos
		@patient_request = PatientRequest.new
		@patient_request.patient = Patient.new

	end

	# GET
	def edit

		# Obtenemos la solicitud
		@patient_request = PatientRequest.find(params[:id])

		# Rendereamos el formulario
		render :new
	end

	# POST
	def create

		# Pasamos los blanks a nils
		params[:patient].each do | key, value |
			if value.blank?
				params[:patient][key] = nil
			end
		end

		# Creamos la solicitd y al paciente
		@patient_request = PatientRequest.new(patient_requets_params)
		@patient = Patient.new(patient_params)
		@patient_request.patient = @patient

		# Campo de como conocio
		@patient_request.how_met = HowMet.new(how_met_params)

		# Checamos la validez
		if @patient.valid? and @patient_request.valid?

			# Estado en espera
			@patient.status = "uncontacted"

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
			flash[:notice] = "¡Ha registrado exitosamente una solicitud!"

			redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
		else
			render :new
		end
	end

	# PATCH
	def update

		# Pasamos los blanks a nils
		params[:patient].each do | key, value |
			if value.blank?
				params[:patient][key] = nil
			end
		end

		# Obtenemos los objetos
		@patient = Patient.find_by_account_number( params[:patient][:account_number] )
		@patient_request = @patient.patient_request

		# Actualizamos
		@patient_request.how_met.update(how_met_params)
		@patient_request.update(patient_requets_params)
		if @patient_request.valid?

			@patient.update(patient_params)
			if @patient.valid?

				# Calculamos la edad del paciente
				@patient.age = age(@patient.birth)

				# Mandamos a renderear de nuevo con mensaje
				flash[:notice] = "¡Ha guardado exitosamente la información de una solicitud!"

				redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
			else
				render :new
			end
		else
			render :new
		end
	end

	# GET
	def request_schedules

		# Obtenemos la solicitud
		patient_request = PatientRequest.find(params[:id])

		# Obtenemos los horarios solicitados
		request_schedules = patient_request.request_schedules

		render json: request_schedules
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
			params.require(:patient_request).permit(:reasons, :condition, :money, :pre_care,
				:affected_areas_attributes => [ :affected_area_type_id, :other_name, :_destroy, :id ],
				:request_schedules_attributes => [ :day, :beginH, :endH, :_destroy, :id ])
		end

		def how_met_params
			params.require(:how_met).permit(:how_met_type_id, :other_name)
		end

		def patient_params
			params.require(:patient).permit(:names, :p_last_name, :m_last_name, :birth, :age, :sex, :account_number, :career,
				:init_school, :semester, :failed_subjects, :telephone1, :telephone2, :email)
		end
end