class PaternalTraitType < ActiveRecord::Base

	# Rasgo paterno en expediente
	has_many :paternal_traits

	# Opciones para el combobox
	def self.options_for_select
		options = Array.new
		PaternalTraitType.all.each do | paternal_trait_type |
			option = [ paternal_trait_type.name, paternal_trait_type.id.to_s ]
			options.push(option)
		end
		return options
	end
end
