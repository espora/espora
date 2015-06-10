# == Schema Information
#
# Table name: cie10_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class Cie10Type < ActiveRecord::Base

	# Expedientes
	has_many :patient_record

	# Opciones para el combobox
	def self.options_for_select

		# Creamos el arreglo de opciones
		options = Array.new

		# Ponemos las de default
		options << ["Sin especificar", nil]

		# Ponemos las opciones del catalogo
		Cie10Type.all.each do | cie10_type |
			option = [ cie10_type.name, cie10_type.id.to_s ]
			options << option
		end
		return options
	end

end
