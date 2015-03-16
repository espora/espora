class Cie10Type < ActiveRecord::Base

	# Expedientes
	has_many :patient_record

	# Opciones para el combobox
	def self.options_for_select
		options = Array.new
		Cie10Type.all.each do | cie10_type |
			option = [ cie10_type.name, cie10_type.id.to_s ]
			options.push(option)
		end
		return options
	end

end
