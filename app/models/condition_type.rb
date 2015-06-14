# == Schema Information
#
# Table name: condition_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class ConditionType < ActiveRecord::Base

	# En solicitud de paciente
	has_many :patient_request

	# En egreso
	has_many :patient_signouts

	# Opciones para el combobox
	def self.options_for_select

		# Creamos el arreglo de opciones
		options = Array.new

		# Ponemos las opciones del catalogo
		ConditionType.all.each do | condition_type |
			option = [ condition_type.name, condition_type.id.to_s ]
			options << option
		end
		return options
	end

end
