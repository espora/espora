class SymptomType < ActiveRecord::Base

	# Sintoma de una cita
	has_many :symptoms

	# Opciones para el combobox
	def self.options_for_select
		options = Array.new
		
		# Agregamos la primera opcion
		options.push(["-", nil])

		# Agregamos las demas opciones
		SymptomType.all.each do | symptom_type |
			option = [ symptom_type.name, symptom_type.id.to_s ]
			options.push(option)
		end

		# Regresamos las opciones
		return options
	end

end
