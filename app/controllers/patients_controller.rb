class PatientsController < ApplicationController

	def new
	end

	def create
	end

	# POST
	def mark_contact
		@patient = Patient.find(params[:id])
	end

end
