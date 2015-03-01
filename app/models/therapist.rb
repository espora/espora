class Therapist < ActiveRecord::Base

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	# Horarios de los terapeutas
	has_many :therapist_schedules

	# Solicitudes de paciente
	has_many :requests_received,  :class_name => 'PatientRequest', :foreign_key => 'receive_therapist_id'
	has_many :requests_contacted, :class_name => 'PatientRequest', :foreign_key => 'contact_therapist_id'

	# Expediente que atiende
	has_many :patient_records

	def matchesPatientSchedule ( patient_request )
		
		patient_request.request_schedules.each do | req_schedule |
		end

		return false
	end
end
