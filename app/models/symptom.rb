class Symptom < ActiveRecord::Base

	# Cita
	belongs_to :appointment

	# Tipo de sintoma
	belongs_to :symptom_type

end
