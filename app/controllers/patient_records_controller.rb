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

			# Renderea el expediente
			render template: "patient_records/havad"
		end
	end
end
