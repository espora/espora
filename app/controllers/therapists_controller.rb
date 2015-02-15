class TherapistsController < ApplicationController

	before_filter :authenticate_therapist!

	# GET
	def show
	end

	# GET
	def profile
		@therapist = Therapist.find(params[:id])
		
		render partial: "profile", locals: { therapist: @therapist }
	end

	# GET
	def new
		@therapist = Therapist.new
		render partial: "form_new_therapist", locals: { therapist: @therapist }
	end

	# POST
	def create
	end

	

end
