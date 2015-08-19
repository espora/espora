class PatientRequestsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist", :only => [ :lue, :new, :edit, :create, :update ]

	# GET
	# Lista de las solicitudes de pacientes.
	# Aplica búsquedas, filtros y ordenamientos.
	def lue

		# Buscamos las solicitudes que solo con los que tienen status esperando o contactado
		condition_str = "patient_status_types.name = 'Sin contactar' or patient_status_types.name = 'Esperando respuesta'"
		@patient_requests = PatientRequest.joins(patient: :patient_status_type).where(condition_str)

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] != ""

				# BUSQUEDA

				# Por apellido paterno
				condition_str = "patients.p_last_name LIKE ? or " +

				# Por apellido materno
				"patients.m_last_name LIKE ? or " +

				# Por nombres
				"patients.names LIKE ? or " +

				# Por numero de cuenta
				"patients.account_number LIKE ?"

				@patient_requests = @patient_requests.joins(:patient).where(condition_str,
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%")
			end
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @patient_requests.size > 0
			if params[:order_by] == "condition"
				@patient_requests = @patient_requests.joins(:condition_type).order("condition_types.id ASC")
			elsif params[:order_by] == "status"
				@patient_requests = @patient_requests.order("patient_status_types.id ASC")
			else
				@patient_requests = @patient_requests.order("patients.#{params[:order_by]} ASC")
			end
		end

		# Paginamos
		if params[:page].nil?
			params[:page] = 1
		end
		@patient_requests = @patient_requests.paginate(:page => params[:page], :per_page => 10)

		# Convertimos a array
		#@patient_requests = @patient_requests.to_a

		# Hay que filtrar
		#if not params[:filter_by].nil?
		#
		#	# Nos quedamos solo los que coinciden en horario con el 
		#	# terapeuta
		#	if params[:filter_by] == "schedule"
		#		@patient_requests.keep_if do | pat_req |
		#			current_therapist.match_schedule?(pat_req)
		#		end
		#	end
		#end

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 0
	end

	# GET
	# Formulario para registrar una nueva solicitud
	def new

		# Creamos los objetos
		@patient_request = PatientRequest.new
		@patient_request.patient = Patient.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 1
	end

	# GET
	# Formulario para editar una nueva solicitud
	def edit

		# Obtenemos la solicitud
		@patient_request = PatientRequest.find(params[:id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 1

		# Panel para las tabs del workspace del lue
		@lue_active_tab = 1

		# Rendereamos el formulario
		render :new
	end

	# POST
	# Crea una nueva solicitud
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
			@patient_status_type = PatientStatusType.find_by_name("Sin contactar")
			@patient.patient_status_type = @patient_status_type

			# Asignamos el paciente
			@patient_request.patient = @patient

			# Asignamos el terapeuta actual como el que recibio la solicitud
			@patient_request.receive_therapist = current_therapist

			# Dar la fecha de registro
			@patient_request.request_date = Time.now

			# Salvamos en la BD
			@patient.save
			@patient_request.save

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = { :patient_request => "¡Ha registrado exitosamente una solicitud!" }

			redirect_to lue_index_path + "?searchStr=" + @patient.account_number.to_s
		else

			# Panel para las tabs del workspace del terapeuta
			@therapist_active_tab = 1

			# Panel para las tabs del workspace del lue
			@lue_active_tab = 1

			render :new
		end
	end

	# PATCH
	# Actualiza la información de una solicitud
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

				# Mandamos a renderear de nuevo con mensaje
				flash[:notice] = { :patient_request => "¡Ha guardado exitosamente la información de una solicitud!" }

				redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
			else
				render :new
			end
		else
			render :new
		end
	end

	# GET
	# Envia un json con los horarios solicitados
	def schedules

		# Obtenemos la solicitud
		patient_request = PatientRequest.find(params[:id])

		# Obtenemos los horarios solicitados
		request_schedules = patient_request.request_schedules

		render json: request_schedules
	end

	# GET
	# Asigna un paciente a un terapeuta através de
	# su solicitud.
	# Con esto se empieza a atender al paciente
	# y se crea su expediente.
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
		@patient_status_type = PatientStatusType.find_by_name("En tratamiento")
		@patient.patient_status_type = @patient_status_type
		@patient.save

		# Guardamos que estamos trabajando con el y enviamos al havad
		redirect_to fosti_index_path
	end

	private

		# Ecapsula los parametros permitidos para una solicitud
		def patient_requets_params
			params.require(:patient_request).permit(:reasons, :condition_type_id, :money, :pre_care,
				:reasons_attributes => [ :reasons_type_id, :other_name, :_destroy, :id ],
				:affected_areas_attributes => [ :personal_area_type_id, :other_name, :_destroy, :id ],
				:request_schedules_attributes => [ :day, :beginH, :endH, :_destroy, :id ])
		end

		# Ecapsula los parametros permitidos para el catalogo Como conocio
		def how_met_params
			params.require(:how_met).permit(:how_met_type_id, :other_name)
		end

		# Ecapsula los parametros permitidos para un paciente
		def patient_params
			params.require(:patient).permit(:names, :p_last_name, :m_last_name, :birth, :age, :sex, :account_number, :career_id,
				:init_school, :semester, :failed_subjects, :telephone1, :telephone2, :email)
		end
end