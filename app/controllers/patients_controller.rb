class PatientsController < ApplicationController

	# GET
	# Marca como contactado al paciente
	# y se pone en espera de respuesta.
	def mark_contacted
		@patient = Patient.find(params[:id])
		@patient_status_type = PatientStatusType.find_by_name("Esperando respuesta")
		@patient.patient_status_type = @patient_status_type
		@patient.save

		redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
	end	

	# GET
	# Marca como desinteresado.
	def mark_uninterested
		@patient = Patient.find(params[:id])
		@patient_status_type = PatientStatusType.find_by_name("Ya no esta interesado")
		@patient.patient_status_type = @patient_status_type
		@patient.save

		redirect_to lue_index_path + "?account_number=" + @patient.account_number.to_s
	end

end