class AppointmentsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist", :only => [ :show, :update, :index, :open ]

	# GET
	# Todas las citas registradas
	# de un expediente.
	def index

		# Obtenemos el expediente
		@patient_record = PatientRecord.find(params[:id])

		# Obtenemos las citas
		@appointments = @patient_record.appointments

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = params[:tab]

		# Panel para las tabs del workspace del open record
		@open_record_active_tab = 2
	end

	# GET
	# Abre una cita (la pone en sesion)
	def open

		# Si no hemos creado la variable de sesion
		if session[:open_records].nil?
			session[:open_records] = Hash.new
		end

		# Si el expediente no está abierto
		if session[:open_records][params[:id]].nil?

			# Pone en sesion al expediente activo
			session[:open_records][params[:id]] = {

				# Id del expediente
				:id => params[:id],

				# Citas abiertas
				:open_appointments => Array.new
			}

			# Redirigimos al havad
			redirect_to havad_index_path(params[:id]) + "?tab=" + params[:tab]
		else

			# Si la cita no esta abierta
			if session[:open_records][params[:id]][:open_appointments].index(params[:appointment_id]).nil?

				# La ponemos en sesion
				session[:open_records][params[:id]][:open_appointments] << params[:appointment_id]
			end

			# Redirigimos al show
			redirect_to show_appointment_path(params[:id], params[:appointment_id]) + "?tab=" + params[:tab] + "&app_tab=" + params[:app_tab]
		end
	end

	# GET
	# Cierra una cita (la elimina de la sesion)
	def close

		# Encontramos el indice en el arreglo
		index = session[:open_records][params[:id]][:open_appointments].index(params[:appointment_id])

		# Quitamos la variable de sesion del paciente elegido
		if not index.nil?
			session[:open_records][params[:id]][:open_appointments].delete_at(index)
		end

		# Redirigimos a las citas del expediente
		redirect_to appointments_path(params[:id]) + "?tab=" + params[:tab]
	end

	# GET
	# Muestra la cita con sus campos para modificar
	def show

		# Obtenemos el expediente por el id
		@patient_record = PatientRecord.find(params[:id])

		# Obtenemos la cita por el id
		@appointment = Appointment.find(params[:appointment_id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = params[:tab]

		# Panel para las tabs del workspace del open record
		@open_record_active_tab = params[:app_tab]
	end

	# POST
	# Crea una cita con los parametros dados
	def create

		# Obtenemos el expediente del paciente actual
		patient_record = PatientRecord.find(params[:id])

		# Creamos la cita
		appointment = Appointment.new(create_appointment_params)
		appointment.number = patient_record.new_appointment_number

		# Asignamos a las citas y guardamos
		patient_record.appointments << appointment
		appointment.save

		# Rendereamos la tabla de citas
		render partial: "appointment_table", locals: { patient_record: patient_record, appointments: patient_record.appointments }
	end

	# PUT
	# Actualiza la informacion de una cita
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
			flash[:notice] = { :appointment => "¡Información de cita guardada éxitosamente!" }

			# Redirigimos al expediente
			redirect_to havad_index_path(@appointment.patient_record.id) + "?tab=" + params[:tab]
		else

			# Redirigimos al show
			redirect_to show_appointment_path(@appointment.patient_record.id, params[:id])
		end
	end

	private

		# Ecapsula los parametros permitidos para actualizar citas
		def appointment_params
			params.require(:appointment).permit(:attended, :notes, :symptoms_attributes => [:symptom_type_id, :level, :_destroy])
		end

		# Ecapsula los parametros permitidos para crear la cita
		def create_appointment_params
			params.permit(:date)
		end
end
