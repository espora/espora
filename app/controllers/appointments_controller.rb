class AppointmentsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :show, :update ]

	# GET
	def show

		# Obtenemos la cita por el id
		@appointment = Appointment.find(params[:id])

	end

	# POST
	def create

		# Obtenemos el expediente del paciente actual
		patient_record = current_patient.patient_record

		# Creamos la cita
		appointment = Appointment.new(create_appointment_params)
		appointment.number = patient_record.next_appointment_number

		# Asignamos a las citas y guardamos
		patient_record.appointments << appointment
		appointment.save

		render partial: "patient_records/appointment_table", locals: { appointments: patient_record.appointments }
	end

	# PUT
	def update

		# Obtenemos la cita
		@appointment = Appointment.find(params[:id])

		# Limpiamos los sintomas vacios
		if not params[:appointment][:symptoms_attributes].nil?
			params[:appointment][:symptoms_attributes].reject! do | key, value |
				not value[:id].nil?
			end
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

		def create_appointment_params
			params.permit(:date)
		end
end
