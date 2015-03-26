class PatientsController < ApplicationController

	def new
	end

	def create
	end

	# GET
	def mark_contacted
		@patient = Patient.find(params[:id])
		@patient.status = "waiting"
		@patient.save

		redirect_to lue_index_path
	end	

	# GET
	def mark_uninterested
		@patient = Patient.find(params[:id])
		@patient.status = "uninterested"
		@patient.save

		redirect_to lue_index_path
	end

end
