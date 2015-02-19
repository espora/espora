class PatientRequestsController < ApplicationController

	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :lue, :new ]

	# GET
	def lue

		# Obtenemos las solicitudes
		@patient_requests = PatientRequest.all

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

		# debug
		ap params

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

				# Salvamos en la BD
				@patient_request.save

				# Mandamos a renderear de nuevo con mensaje
				flash[:notice] = "¡Ha registrado exitosamente un paciente!"
				render partial: "form", locals: { patient_request: @patient_request, flash: flash }
			else
				puts "::::::::::::::::::::::::"
				puts @patient_request.errors.size
				puts "NO ES VALIDO EL PACIENTE NO ES VALIDO EL PACIENTE NO ES VALIDO EL PACIENTE NO ES VALIDO EL PACIENTE NO ES VALIDO EL PACIENTE NO ES VALIDO EL PACIENTE "
				render partial: "form", locals: { patient_request: @patient_request, flash: flash }
			end
		else
			render :new
		end
	end

	# POST
	def lue_search
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