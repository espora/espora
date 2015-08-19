class PatientRecordsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise - Verifica que el terapeuta este loggeado
	before_filter :authenticate_therapist!

	# Layout de terapeuta
	layout "therapist", :only => [ :fosti, :havad, :patient ]

	# GET
	# Lista de los expedientes de un terapeuta.
	# Aplica búsquedas y ordenamientos.
	def fosti

		# Obtenemos los expedientes actuales del terapeuta
		@patient_records = current_therapist.on_treatment_records

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] != ""

				# BUSQUEDA

				# Por apellido paterno
				condition_str = "patients.p_last_name LIKE ? or " +

				# Por apellido materno
				"patients.m_last_name LIKE ? or " +

				# Por nombres
				"patients.names LIKE ? or " +

				# Por numero de cuenta
				"patients.account_number LIKE ?"

				# Por apellido paterno
				@patient_records = @patient_records.joins(:patient).where(condition_str,
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%")
			end
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @patient_records.count > 0
			case params[:order_by]
			when "full_name"
				@patient_records = @patient_records.order("patients.p_last_name ASC")
			when "admission_date"
				@patient_records = @patient_records.order("created_at DESC")
			when "age"
				@patient_records = @patient_records.order("patients.birth DESC")
			when "career"
				@patient_records = @patient_records.joins(patient: :career).order("careers.name ASC")
			else
				@patient_records = @patient_records.order("patients.#{params[:order_by]} ASC")
			end
		end

		# Paginamos
		if params[:page].nil?
			params[:page] = 1
		end
		@patient_records = @patient_records.paginate(:page => params[:page], :per_page => 10)

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 2
	end

	# PUT
	# Actualiza la información de un expediente
	def update

		# Obtenemos el expediente y hacemos update de lo mandado
		@patient_record = PatientRecord.find(params[:id])
		@patient_record.update(patient_records_params)
		if @patient_record.valid?

			# Obtenemos un arreglo con los mecanismos que indicaron y agregamos los que ya estan
			mechanism_types = Array.new
			if not params[:patient_record][:mechanism_types_attributes].nil?
				params[:patient_record][:mechanism_types_attributes].each do | key, value |
					mechanism_type = MechanismType.find(value[:id])
					mechanism_types << mechanism_type

					# Pregunamos si ya lo tiene
					if not @patient_record.mechanism_types.include?(mechanism_type)
						@patient_record.mechanism_types << mechanism_type
					end
				end
			end

			# Quitamos los mecanismos que ya no hayan estado
			@patient_record.mechanism_types.each do | mechanism_type |
				if not mechanism_types.include?(mechanism_type)
					@patient_record.mechanism_types.delete(mechanism_type)
				end
			end

			# Obtenemos un arreglo con las experiencias que indicaron y agregamos los que ya estan
			experience_types = Array.new
			if not params[:patient_record][:experience_types_attributes].nil?
				params[:patient_record][:experience_types_attributes].each do | key, value |
					experience_type = ExperienceType.find(value[:id])
					experience_types << experience_type

					# Pregunamos si ya lo tiene
					if not @patient_record.experience_types.include?(experience_type)
						@patient_record.experience_types << experience_type
					end
				end
			end

			# Quitamos las experiencias que ya no hayan estado
			@patient_record.experience_types.each do | experience_type |
				if not experience_types.include?(experience_type)
					@patient_record.experience_types.delete(experience_type)
				end
			end

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = { :patient_record => "¡Información de expediente guardada éxitosamente!" }

			# Redirigimos al havad
			redirect_to havad_index_path(params[:id]) + "?tab=" + params[:tab]
		end
	end

	# GET
	# Pone un expediente en sesión (se pone como abierto)
	def open

		# Si no hemos creado la variable de sesion
		if session[:open_records].nil?
			session[:open_records] = Hash.new
		end

		# Si no está abierto
		if session[:open_records][params[:id]].nil?

			# Pone en sesion al expediente activo
			session[:open_records][params[:id]] = {

				# Id del expediente
				:id => params[:id],

				# Pestaña donde esta abierta
				:tab => params[:tab].to_i,

				# Citas abiertas
				:open_appointments => Array.new
			}
		end

		# Redirigimos al havad del paciente
		redirect_to patient_index_path(params[:id]) + "?tab=" + session[:open_records][params[:id]][:tab].to_s
	end

	# GET
	# Muestra la hoja de datos del expediente
	def havad

		# Encontramos el expediente
		@patient_record = PatientRecord.find(params[:id])

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = params[:tab]

		# Panel para las tabs del workspace del open record
		@open_record_active_tab = 1
	end

	# GET
	# Muestra la informacion del paciente
	def patient

		# Encontramos expediente y paciente
		@patient_record = PatientRecord.find(params[:id])
		@patient = @patient_record.patient
		@patient_request = @patient.patient_request

		# Creamos la canalización
		@channelization = PatientChannelization.new

		# Creamos el egreso
		@signout = PatientSignout.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = params[:tab]

		# Panel para las tabs del workspace del open record
		@open_record_active_tab = 0
	end

	# GET
	# Obtiene los eventos para el fullcallendar
	def appointments_events

		# Obtenemos el expediente
		@patient_record = PatientRecord.find(params[:id])

		# Obtenemos las citas
		appointments = @patient_record.appointments.to_a

		# Ponemos la informacion como va
		tab_index = open_appointments(@patient_record).count + 3
		appointments.map! do |e|
			{
				"idAppointment" => e.id.to_s,
				"title" => "Cita " + e.number.to_s,
				"start" => e.date.strftime("%Y-%m-%d") + "T" + e.date.strftime("%H:%M"),
				"open" => open_appointment_path(@patient_record, e) + "?tab=" + params[:tab] + "&app_tab=" + tab_index.to_s
			}
		end

		render json: appointments
	end

	# GET
	# Cierra un expedientede la sesion
	def close

		# Corrigiendo las pestañas

		# Obtenemos los id ordenados
		open_records_ids = session[:open_records].keys.sort do |x,y| 
			session[:open_records][x][:tab] <=> session[:open_records][y][:tab]
		end

		# Obtenemos el indice del id que se va a cerrar
		idx_to_delete = open_records_ids.index(params[:id]) + 1

		# Le restamos un tab a las demas
		(idx_to_delete ... open_records_ids.size).each do |i|
			record_id = open_records_ids[i]
			session[:open_records][record_id][:tab] = session[:open_records][record_id][:tab].to_i - 1
		end

		# Quitamos la variable de sesion del paciente elegido
		if not session[:open_records][params[:id]].nil?
			session[:open_records].delete(params[:id])
		end

		# Redirigimos al fosti
		redirect_to fosti_index_path
	end

	private

		# Ecapsula los parametros permitidos para un expediente
		def patient_records_params
			params.require(:patient_record).permit(:lives_with, :observations, :cie10_type_id, :clinical_structure_type_id,
				:paternal_traits_attributes => [:id, :paternal_trait_type_id])
		end
end
