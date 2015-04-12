class ClinicalStructureType < ActiveRecord::Base

	# Expedientes
	has_many :patient_record

	# Opciones para el combobox
	def self.options_for_select
		options = Array.new
		ClinicalStructureType.all.each do | clinical_structure_type |
			option = [ clinical_structure_type.name, clinical_structure_type.id.to_s ]
			options.push(option)
		end
		return options
	end

end
