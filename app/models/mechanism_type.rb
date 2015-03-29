class MechanismType < ActiveRecord::Base

	# Expedientes
	has_and_belongs_to_many :patient_records

	# Opciones para el combobox
	def self.options_for_select
		options = Array.new
		MechanismType.all.each do | mechanism_type |
			option = [ mechanism_type.name, mechanism_type.id.to_s ]
			options.push(option)
		end
		return options
	end

end