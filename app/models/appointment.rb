class Appointment < ActiveRecord::Base

	# Pertenece a un expediente
	belongs_to :patient_record

	# Sintomas detectados
	has_many :symptoms, :dependent => :destroy

end
