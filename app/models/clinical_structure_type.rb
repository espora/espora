# == Schema Information
#
# Table name: clinical_structure_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class ClinicalStructureType < ActiveRecord::Base

	# Expedientes
	has_many :patient_record

	# Opciones para el combobox
	def self.options_for_select
		# Creamos el arreglo de opciones
		options = Array.new

		# Ponemos las de default
		options << ["Sin especificar", nil]

		# Ponemos las opciones del catalogo
		ClinicalStructureType.all.each do | clinical_structure_type |
			option = [ clinical_structure_type.name, clinical_structure_type.id.to_s ]
			options.push(option)
		end
		
		return options
	end

end
