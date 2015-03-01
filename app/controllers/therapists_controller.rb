class TherapistsController < ApplicationController

	before_filter :authenticate_therapist!

	# Layout
	layout "therapist"

	# GET
	def profile

		# Obtenemos el terapeuta
		@therapist = Therapist.find(params[:id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 0
	end

	# GET
	def new
		@therapist = Therapist.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 2
	end

	# POST
	def create
	end

end
