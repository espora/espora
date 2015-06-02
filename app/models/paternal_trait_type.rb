class PaternalTraitType < ActiveRecord::Base

	# Rasgo paterno en expediente
	has_many :paternal_traits

	# Opciones para el combobox
	def self.options_for_select

		# Creamos el arreglo de opciones
		options = Array.new

		# Ponemos las de default
		options << ["Sin especificar", nil]

		# Ponemos las opciones del catalogo
		PaternalTraitType.all.each do | paternal_trait_type |
			option = [ paternal_trait_type.name, paternal_trait_type.id.to_s ]
			options << option
		end

		return options
	end
end
