class PatientDropoutsController < ApplicationController

	# Layout de terapeuta
	layout "therapist", :only => [ :index ]

	def index

		# Obtenemos las bajas
		@dropouts = current_therapist.dropout_records
		@uninterested = nil

		# Aplicamos el filtro
		if not params[:filter_by].nil?
			case params[:filter_by]
			when "none"
				@uninterested = PatientStatusType.find_by_name("Ya no esta interesado").patients
			when "uninterested"
				@dropouts = nil
				@uninterested = PatientStatusType.find_by_name("Ya no esta interesado").patients
			when "interrupted"
				@dropouts = @dropouts.joins(:patient_dropout_type).where("patient_dropout_types.name = ?", "Interrupción")
			when "abandoned"
				@dropouts = @dropouts.joins(:patient_dropout_type).where("patient_dropout_types.name = ?", "Abandono")
			when "channelized"
				@dropouts = @dropouts.joins(:patient_dropout_type).where("patient_dropout_types.name = ?", "Canalizado")
			when "ended"
				@dropouts = @dropouts.joins(:patient_dropout_type).where("patient_dropout_types.name = ?", "Finalizado")
			end
		else

			# Obtenemos los desinteresados
			@uninterested = PatientStatusType.find_by_name("Ya no esta interesado").patients
		end

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

				if not @dropouts.nil?
					@dropouts = @dropouts.joins(:patient).where(condition_str,
						"%#{params[:searchStr]}%",
						"%#{params[:searchStr]}%",
						"%#{params[:searchStr]}%",
						"%#{params[:searchStr]}%")
				end

				if not @uninterested.nil?
					@uninterested = @uninterested.where(condition_str,
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%",
					"%#{params[:searchStr]}%")
				end
			end
		end

		# Hay que ordenar
		if not params[:order_by].nil? and @dropouts.count > 0
			case params[:order_by]
			when "dropout_date"
			when "full_name"
			else
			end
		end

		# Paginamos
		if params[:page].nil?
			params[:page] = 1
		end
		if not @dropouts.nil?
			@dropouts = @dropouts.paginate(:page => params[:page], :per_page => 10)
		end
		if not @uninterested.nil?
			@uninterested = @uninterested.paginate(:page => params[:page], :per_page => 10)
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
		redirect_to patient_dropouts_index_path + "?searchStr=" + @patient.account_number.to_s
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
		redirect_to patient_dropouts_index_path + "?searchStr=" + @patient.account_number.to_s
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
		redirect_to patient_dropouts_index_path + "?searchStr=" + @patient.account_number.to_s
	end

	def create_signout

		# Obtenemos al paciente
		@patient = PatientRecord.find(params[:id]).patient

		# Obtenemos el tipo de baja
		@dropout_type = PatientDropoutType.find_by_name("Finalizado")

		# Creamos la baja con su tipo y paciente
		@patient_dropout = PatientDropout.new
		@patient_dropout.patient = @patient
		@patient_dropout.patient_dropout_type = @dropout_type

		# Creamos el egreso
		@patient_signout = PatientSignout.new(patient_signout_params)
		@patient_signout.patient_dropout = @patient_dropout

		# Alteramos el estado del paciente
		@patient_status_type = PatientStatusType.find_by_name("Baja")
		@patient.patient_status_type = @patient_status_type

		# Salvamos a base
		@patient.save
		@patient_dropout.save
		@patient_signout.save

		# Quitamos la variable de sesion del paciente elegido
		if not session[:open_records][params[:id]].nil?
			session[:open_records].delete(params[:id])
		end

		# Redirigimos a las bajas
		redirect_to patient_dropouts_index_path + "?searchStr=" + @patient.account_number.to_s		
	end

	private

		# Ecapsula los parametros permitidos para un egreso
		def patient_signout_params
			params.require(:patient_signout).permit(:aid_level_type_id, :condition_type_id,
				:rating, :advise_level_type_id, :satisfactions, :claims, :observations,
				:improve_areas_attributes => [ :personal_area_type_id, :other_name, :_destroy, :id ])
		end
end
