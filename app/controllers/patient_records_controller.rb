class PatientRecordsController < ApplicationController

	# Incluir las funciones de ayuda de la aplicacion
	include ApplicationHelper

	# Devise
	before_filter :authenticate_therapist!

	# Layout para el terapeuta
	layout "therapist", :only => [ :havad ]

	# GET
	def havad

		# El Array que se ira llenando
		@patient_records = Array.new

		# Panel para las tabs del workspace del terapeuta
		@therapist_active_tab = 2

		# Panel para las tabs del workspace del havad
		@havad_active_tab = 0

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
		puts "entra a UPDATE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		# debug
		ap params

		@patient_record = PatientRecord.find(params[:id])
		@patient_record.update(patient_records_params)
		if @patient_record.valid?

			# Salvamos en la BD
			@patient_record.save

			# Mandamos a renderear de nuevo con mensaje
			flash[:notice] = "¡Ha guardado exitosamente un expediente!"

			redirect_to havad_index_path
		else
			puts "!!!!!!!!!!!!!!!!!!!!"
			puts @patient_record
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
			params.require(:patient_record).permit(:lives_with, :observations)
		end
end
