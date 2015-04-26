class TherapistsController < ApplicationController

	before_filter :authenticate_therapist!

	# Layout
	layout "therapist"

	# GET
	def profile

		# Obtenemos el terapeuta
		@therapist = Therapist.find(params[:id])
	end

	#HAVAD
	def havad
		
	end

	# GET
	def new
		@therapist = Therapist.new
	end

	# POST
	def create
	end

end
