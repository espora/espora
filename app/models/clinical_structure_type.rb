class ClinicalStructureType < ActiveRecord::Base

	# Expedientes
	has_many :patient_record

end
