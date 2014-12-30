class PatientRequestsController < ApplicationController

	# GET
	def new
		@patient_request = PatientRequest.new
		@patient_request.patient = Patient.new

		render partial: "patient_requests/form_new_lue", locals: { patient_request: @patient_request }
	end
end
