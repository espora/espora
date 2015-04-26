class AppointmentsController < ApplicationController

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :show, :update ]

	# GET
	def show

		# Obtenemos la cita por el id
		@appointment = Appointment.find(params[:id])

	end

	# PUT
	def update

		# debug
		ap params

		# Obtenemos la cita
		@appointment = Appointment.find(params[:id])

		# Limpiamos los sintomas vacios
		params[:appointment][:symptoms_attributes].reject! do | key, value |
			not value[:id].nil?
		end

		# Hacemos update
		@appointment.update(appointment_params)
		if @appointment.valid?

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = "¡Información de cita guardada éxitosamente!"

			# Redirigimos al expediente
			redirect_to havad_index_path
		else

			# Redirigimos al show
			redirect_to show_appointment_path(params[:id])
		end
	end

	private

		def appointment_params
			params.require(:appointment).permit(:attended, :notes, :symptoms_attributes => [:symptom_type_id, :level, :_destroy])
		end

end
