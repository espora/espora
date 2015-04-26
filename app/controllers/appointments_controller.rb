class AppointmentsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :show, :update ]

	# GET
	def show

		# Obtenemos la cita por el id
		@appointment = Appointment.find(params[:id])

		# Le acompletamos los 5 signos y sintomas si no los tiene aún
		dif = 5 - @appointment.symptoms.count
		dif.times do | i |
			@appointment.symptoms.build
		end
	end

	# PUT
	def update
	end

end
