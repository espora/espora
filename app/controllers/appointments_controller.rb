class AppointmentsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :show ]

	# GET
	def show

		# Obtenemos la cita por el id
		@appointment = Appointment.find(params[:id])

		

		# Redirigimos al havad
		redirect_to havad_index_path
	end

end
