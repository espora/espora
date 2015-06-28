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

	# Motivos de consulta de una solicitud
	has_many :reasons

	# Devuelve true si el tipo es Otro
	def is_other?
		return self.name === "Otros"
	end
	
end
