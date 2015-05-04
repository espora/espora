class Appointment < ActiveRecord::Base

	# Expediente
	belongs_to :patient_record

	# Sintomas detectados
	has_many :symptoms, :dependent => :destroy

	# Sintomas en formularios anidados
	accepts_nested_attributes_for :symptoms, :allow_destroy => true,
	:reject_if => proc { |attrs| attrs["symptom_type_id"].blank? or attrs["level"].blank? }

end
