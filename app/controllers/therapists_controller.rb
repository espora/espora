class TherapistsController < ApplicationController

	before_filter :authenticate_therapist!

	# GET
	def show
	end

end
