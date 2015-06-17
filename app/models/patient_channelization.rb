class PatientChannelization < ActiveRecord::Base

	# Baja de paciente
	belongs_to :patient_dropout
	
end
