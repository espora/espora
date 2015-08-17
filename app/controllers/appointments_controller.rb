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

		# Guardamos en variables los parametros
		id = params[:id]
		appoint_id = params[:appointment_id]

		# Creamos el registro
		appoint_register = {

			# Id de la cita
			:id => appoint_id,

			# Pestaña donde esta abierta la cita
			:tab => params[:app_tab].to_i
		}

		# Si no hemos creado la variable de sesion
		if session[:open_records].nil?
			session[:open_records] = Hash.new
		end

		# Si el expediente no está abierto
		if session[:open_records][id].nil?

			# Pone en sesion al expediente activo
			session[:open_records][id] = {

				# Id del expediente
				:id => id,

				# Pestaña donde esta abierto el expediente
				:tab => params[:tab].to_i,

				# Citas abiertas
				:open_appointments => [ appoint_register ]
			}
		else

			# Buscamos la cita
			aux = nil
			session[:open_records][id][:open_appointments].each do |open_app|
				if open_app[:id] == appoint_id
					aux = open_app
				end
			end

			# Si no estaba, la ponemos en sesion
			if aux.nil?
				session[:open_records][id][:open_appointments] << appoint_register
			else
				appoint_register = aux
			end
		end

		# Obtenemos el app_tab
		app_tab = appoint_register[:tab].to_s

		# Redirigimos al show
		redirect_to show_appointment_path(id, appoint_id) + "?tab=" + params[:tab] + "&app_tab=" + app_tab
	end

	# GET
	# Cierra una cita (la elimina de la sesion)
	def close

		# Guardamos en variables los parametros
		id = params[:id]
		appoint_id = params[:appointment_id]

		# Corrigiendo las pestañas

		# Ordenamos por tab
		session[:open_records][id][:open_appointments].sort! do |x,y|
			x[:tab] <=> y[:tab]
		end

		# Obtenemos el indice del id que se va a cerrar
		idx_to_delete = -1
		to_delete = nil
		session[:open_records][id][:open_appointments].each_with_index do |open_app, i|
			if open_app[:id] == appoint_id
				idx_to_delete = i + 1
				to_delete = open_app
			end
		end

		if idx_to_delete != -1

			# Le restamos un tab a las demas
			(idx_to_delete ... session[:open_records][id][:open_appointments].size).each do |i|
				open_app = session[:open_records][id][:open_appointments][i]
				open_app[:tab] = open_app[:tab].to_i - 1
			end

			# Quitamos la variable de sesion de la cita elegida
			session[:open_records][id][:open_appointments].delete(to_delete)
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

		# Armamos la fecha
		params[:date] = params[:day] + " " + params[:hour]

		# Creamos la cita
		appointment = Appointment.new(create_appointment_params)
		appointment.number = patient_record.new_appointment_number

		# Asignamos a las citas y guardamos
		patient_record.appointments << appointment
		appointment.save

		# Redirigimos a las citas
		redirect_to appointments_path(patient_record) + "?tab=" + params[:tab]
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
			redirect_to appointments_path(@appointment.patient_record.id) + "?tab=" + params[:tab]
		else

			# Redirigimos al show
			redirect_to show_appointment_path(@appointment.patient_record.id, params[:id])
		end
	end

	# POST
	# Actualiza la fecha de una cita
	def update_date

		# Obtenemos la cita
		@appointment = Appointment.find(params[:id])

		# Actualizamos la fecha
		@appointment.update_attributes(:date => params[:date])

		# Rendereamos un ok
		render json: "updated".to_json
	end

	# POST
	# Elimina una cita
	def delete

		# Obtenemos la cita y la eliminamos
		Appointment.find(params[:id]).destroy

		render json: "deleted".to_json
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
