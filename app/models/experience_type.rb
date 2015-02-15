class ExperienceType < ActiveRecord::Base

	# Expedientes
	has_and_belongs_to_many :patient_records
	
end
