class PatientsController < ApplicationController

	# GET
	# Marca como contactado al paciente
	# y se pone en espera de respuesta.
	def mark_contacted
		@patient = Patient.find(params[:id])
		@patient.status = "waiting"
		@patient.save

		redirect_to lue_index_path
	end	

	# GET
	# Marca como desinteresado.
	def mark_uninterested
		@patient = Patient.find(params[:id])
		@patient.status = "uninterested"
		@patient.save

		redirect_to lue_index_path
	end

end