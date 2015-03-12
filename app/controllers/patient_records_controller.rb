class PatientRecordsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :havad ]

	# GET
	def havad

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 2

		# Panel para las tabs del workspace del havad
		@havad_active_tab = 0

		# Mandando a renderear
		if session[:current_patient].nil?

			@patient_records = current_therapist.patient_records

			# Si no hay paciente entonces fosti
			render template: "patient_records/fosti"
		else

			# Obtener el paciente
			@current_patient = Patient.find(session[:current_patient])
			@current_record = @current_patient.patient_record

			# Renderea el expediente
			render template: "patient_records/havad"
		end
	end

	# GET
	def choose
		
		# Pone en sesion al expediente activo
		session[:current_patient] = params[:id]

		redirect_to havad_index_path
	end

	#POST
	def create
	end
end
