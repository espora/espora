class SymptomType < ActiveRecord::Base

	# Sintoma de una cita
	has_many :symptoms

end
