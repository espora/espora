class PatientRecordsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :havad ]

	# GET
	def havad

		# Mandando a renderear
		if current_patient.nil?
			@patient_records = current_therapist.patient_records

			# Si no hay paciente entonces fosti
			render template: "patient_records/fosti"
		else

			# Obtener el paciente
			@current_record = current_patient.patient_record

			# Renderea el expediente
			render template: "patient_records/havad"
		end
	end

	# PUT
	def update

		# Obtenemos el expediente y hacemos update de lo mandado
		@patient_record = PatientRecord.find(params[:id])
		@patient_record.update(patient_records_params)
		if @patient_record.valid?

			# Obtenemos un arreglo con los mecanismos que indicaron y agregamos los que ya estan
			mechanism_types = Array.new
			params[:patient_record][:mechanism_types_attributes].each do | key, value |
				mechanism_type = MechanismType.find(value[:id])
				mechanism_types << mechanism_type

				# Pregunamos si ya lo tiene
				if not @patient_record.mechanism_types.include?(mechanism_type)
					@patient_record.mechanism_types << mechanism_type
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
			params[:patient_record][:experience_types_attributes].each do | key, value |
				experience_type = ExperienceType.find(value[:id])
				experience_types << experience_type

				# Pregunamos si ya lo tiene
				if not @patient_record.experience_types.include?(experience_type)
					@patient_record.experience_types << experience_type
				end
			end

			# Quitamos las experiencias que ya no hayan estado
			@patient_record.experience_types.each do | experience_type |
				if not experience_types.include?(experience_type)
					@patient_record.experience_types.delete(experience_type)
				end
			end

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = "¡Información de expediente guardada éxitosamente!"

			redirect_to havad_index_path
		else

		end
	end

	# GET
	def choose
		
		# Pone en sesion al expediente activo
		session[:current_patient_id] = params[:id]

		# Redirigimos al havad
		redirect_to havad_index_path
	end


	def close

		# Quitamos la variable de sesion del aciente elegido
		session.delete(:current_patient_id)

		# Redirigimos al path
		redirect_to therapist_profile_path(current_therapist)
	end

	private

		def patient_records_params
			params.require(:patient_record).permit(:lives_with, :observations, :cie10_type_id, :clinical_structure_type_id,
				:paternal_traits_attributes => [:id, :paternal_trait_type_id])
		end
end
