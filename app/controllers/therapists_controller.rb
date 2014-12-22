class TherapistsController < ApplicationController

	before_filter :authenticate_therapist!

	# GET
	def show
	end

	# GET
	def new
		@therapist = Therapist.new
		render partial: "therapists/form_new_therapist", locals: { therapist: @therapist }
	end

end
