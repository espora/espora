# == Schema Information
#
# Table name: reasons_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class ReasonsType < ActiveRecord::Base

<<<<<<< HEAD
	# Solicitud de paciente
	has_and_belongs_to_many :patient_requests
=======
	# Motivos de consulta de una solicitud
	has_many :reasons

	# Devuelve true si el tipo es Otro
	def is_other?
		return self.name === "Otro"
	end
>>>>>>> 5db6aa4c5cf297d7af59c8239a2a5f125df37d00
	
end
