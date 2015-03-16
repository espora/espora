class PatientsController < ApplicationController

	def new
	end

	def create
	end

	# POST
	def mark_contact
		@patient = Patient.find(params[:id])
		@patient.status = "contacted"
		@patient.save

		redirect_to lue_index_path
	end

end
