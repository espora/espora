class PatientDropoutsController < ApplicationController

	# Layout de terapeuta
	layout "therapist", :only => [ :index ]

	def index

		# El Array que se ira llenando
		@dropouts = Array.new

		# Seleccionamos el estatus de no interesado
		@uninterested_status = PatientStatusType.find_by_name("Ya no esta interesado")

		# Nos pasaron un numero de cuenta?
		if not params[:account_number].nil?

			# Buscamos un paciente con el numero de cuenta y regresamos
			patient = Patient.find_by_account_number(params[:account_number])
			@dropouts.concat([ patient.patient_dropout ])
		end

		# Estan buscando algo?
		if not params[:searchStr].nil?
			if params[:searchStr] == ""

				# Viene vacio, entonces mandamos todas
				@dropouts = PatientDropout.all
				@dropouts.concat(@uninterested_status.patients)
			else

				# BUSQUEDA

				# Por apellido paterno
				@dropouts.concat(PatientDropout.joins(:patient).where("p_last_name LIKE ?", "%#{params[:searchStr]}%"))
				@dropouts.concat(@uninterested_status.patients.where("p_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por apellido materno
				@dropouts.concat(PatientDropout.joins(:patient).where("m_last_name LIKE ?", "%#{params[:searchStr]}%"))
				@dropouts.concat(@uninterested_status.patients.where("m_last_name LIKE ?", "%#{params[:searchStr]}%"))

				# Por nombres
				@dropouts.concat(PatientDropout.joins(:patient).where("names LIKE ?", "%#{params[:searchStr]}%"))
				@dropouts.concat(@uninterested_status.patients.where("names LIKE ?", "%#{params[:searchStr]}%"))

				# Por numero de cuenta
				@dropouts.concat(PatientDropout.joins(:patient).where("account_number LIKE ?", "%#{params[:searchStr]}%"))
				@dropouts.concat(@uninterested_status.patients.where("account_number LIKE ?", "%#{params[:searchStr]}%"))

				# Eliminamos repetidos
				@dropouts.uniq!
			end
		else
		end

		# Si no hubo ninguno hay que solicitar todos
		if params[:account_number].nil? and params[:searchStr].nil?
			@dropouts = PatientDropout.all
			@dropouts.concat(@uninterested_status.patients)
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @dropouts.count > 0
			@dropouts.sort! { |x, y|
				case params[:order_by]
				when "dropout_date"
					dropout_date_x = x.is_a?(PatientDropout) ? x.created_at : x.updated_at
					dropout_date_y = y.is_a?(PatientDropout) ? y.created_at : y.updated_at
					dropout_date_x <=> dropout_date_y
				when "full_name"
					patient_x = x.is_a?(PatientDropout) ? x.patient : x
					patient_y = y.is_a?(PatientDropout) ? y.patient : y
					patient_x.full_name <=> patient_y.full_name
				else
					patient_x = x.is_a?(PatientDropout) ? x.patient : x
					patient_y = y.is_a?(PatientDropout) ? y.patient : y
					patient_x.attributes[params[:order_by]] <=> patient_y.attributes[params[:order_by]]
				end
			}
		end

		# Convertimos a array
		@dropouts = @dropouts.to_a

		# Hay que filtrar
		if not params[:filter_by].nil?
			case params[:filter_by]
			when "uninterested"
				@dropouts.keep_if do | dropout |
					dropout.is_a?(Patient)
				end
			when "interrupted"
				@dropouts.keep_if do | dropout |
					dropout.is_a?(PatientDropout) and dropout.patient_dropout_type.name == "Interrupción"
				end
			when "abandoned"
				@dropouts.keep_if do | dropout |
					dropout.is_a?(PatientDropout) and dropout.patient_dropout_type.name == "Abandono"
				end
			when "channelized"
				@dropouts.keep_if do | dropout |
					dropout.is_a?(PatientDropout) and dropout.patient_dropout_type.name == "Canalizado"
				end
			when "ended"
				@dropouts.keep_if do | dropout |
					dropout.is_a?(PatientDropout) and dropout.patient_dropout_type.name == "Finalizado"
				end
			end
		end

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 3
	end

	def create_channelization

		# Obtenemos el paciente
		@patient = Patient.find(params[:patient_channelization][:patient_id])

		# Obtenemos el tipo de baja
		@dropout_type = PatientDropoutType.find_by_name("Canalizado")

		# Creamos la baja con su tipo
		@patient_dropout = PatientDropout.new
		@patient_dropout.patient = @patient
		@patient_dropout.patient_dropout_type = @dropout_type

		# Creamos la canalizacion
		@patient_channelization = PatientChannelization.new
		@patient_channelization.where = params[:patient_channelization][:where]
		@patient_channelization.patient_dropout = @patient_dropout

		# Alteramos el estado del paciente
		@patient_status_type = PatientStatusType.find_by_name("Baja")
		@patient.patient_status_type = @patient_status_type

		# Salvamos a base
		@patient.save
		@patient_dropout.save
		@patient_channelization.save

		# Quitamos la variable de sesion del paciente elegido
		if not session[:open_records][@patient.patient_record.id.to_s].nil?
			session[:open_records].delete(@patient.patient_record.id.to_s)
		end

		# Redirigimos a las bajas
		redirect_to patient_dropouts_index_path + "?account_number=" + @patient.account_number.to_s
	end

	def create_interruption

		# Obtenemos al paciente
		@patient = Patient.find(params[:id])

		# Obtenemos el tipo de baja
		@dropout_type = PatientDropoutType.find_by_name("Interrupción")

		# Creamos la baja con su tipo y paciente
		@patient_dropout = PatientDropout.new
		@patient_dropout.patient = @patient
		@patient_dropout.patient_dropout_type = @dropout_type

		# Alteramos el estado del paciente
		@patient_status_type = PatientStatusType.find_by_name("Baja")
		@patient.patient_status_type = @patient_status_type

		# Salvamos a base
		@patient.save
		@patient_dropout.save

		# Quitamos la variable de sesion del paciente elegido
		if not session[:open_records][@patient.patient_record.id.to_s].nil?
			session[:open_records].delete(@patient.patient_record.id.to_s)
		end

		# Redirigimos a las bajas
		redirect_to patient_dropouts_index_path + "?account_number=" + @patient.account_number.to_s
	end

	def create_abandonment

		# Obtenemos al paciente
		@patient = Patient.find(params[:id])

		# Obtenemos el tipo de baja
		@dropout_type = PatientDropoutType.find_by_name("Abandono")

		# Creamos la baja con su tipo y paciente
		@patient_dropout = PatientDropout.new
		@patient_dropout.patient = @patient
		@patient_dropout.patient_dropout_type = @dropout_type

		# Alteramos el estado del paciente
		@patient_status_type = PatientStatusType.find_by_name("Baja")
		@patient.patient_status_type = @patient_status_type

		# Salvamos a base
		@patient.save
		@patient_dropout.save

		# Quitamos la variable de sesion del paciente elegido
		if not session[:open_records][@patient.patient_record.id.to_s].nil?
			session[:open_records].delete(@patient.patient_record.id.to_s)
		end

		# Redirigimos a las bajas
		redirect_to patient_dropouts_index_path + "?account_number=" + @patient.account_number.to_s
	end

	def patient_fill_signout
	end
end