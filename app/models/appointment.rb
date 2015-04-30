class Appointment < ActiveRecord::Base

	# Pertenece a un expediente
	belongs_to :patient_record

	# Sintomas detectados
	has_many :symptoms, :dependent => :destroy
	accepts_nested_attributes_for :symptoms, :allow_destroy => true,
	:reject_if => proc { |attrs| attrs["symptom_type_id"].blank? or attrs["level"].blank? }


end
