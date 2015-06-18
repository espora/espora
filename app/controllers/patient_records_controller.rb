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

		# El Array que se ira llenando
		@patient_records = Array.new

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] == ""

				# Viene vacio, entonces mandamos todas
				@patient_records = current_therapist.patient_records
			else

				# BUSQUEDA

				# Por apellido paterno
				@patient_records.concat(current_therapist.patient_records.joins(:patient).where("p_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por apellido materno
				@patient_records.concat(current_therapist.patient_records.joins(:patient).where("m_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por nombres
				@patient_records.concat(current_therapist.patient_records.joins(:patient).where("names LIKE ?", "%#{params[:searchStr]}%"))

				# Por numero de cuenta
				@patient_records.concat(current_therapist.patient_records.joins(:patient).where("account_number LIKE ?", "%#{params[:searchStr]}%"))

				# Eliminamos repetidos
				@patient_records.uniq!
			end
		else

			# Viene vacio, entonces mandamos todas
			@patient_records = current_therapist.patient_records
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @patient_records.count > 0
			@patient_records.sort! { |x, y|
				case params[:order_by]
				when "full_name"
					x.patient.full_name <=> y.patient.full_name
				when "admission_date"
					x.created_at <=> y.created_at
				else
					x.patient.attributes[params[:order_by]] <=> y.patient.attributes[params[:order_by]]
				end
			}
		end

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

				# Citas abiertas
				:open_appointments => Array.new
			}

			# Redirigimos al havad
			redirect_to havad_index_path(params[:id]) + "?tab=" + params[:tab]
		else

			# Redirigimos al fosti
			redirect_to fosti_index_path
		end
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

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = params[:tab]

		# Panel para las tabs del workspace del open record
		@open_record_active_tab = 0
	end

	# GET
	# Cierra un expedientede la sesion
	def close

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
