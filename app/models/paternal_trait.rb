class PaternalTrait < ActiveRecord::Base

	# Expediente de paciente
	belongs_to :patient_record

	# Tipo de rasgo paterno
	belongs_to :paternal_trait_type

end
