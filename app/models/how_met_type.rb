# == Schema Information
#
# Table name: how_met_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class HowMetType < ActiveRecord::Base

	# Como conocios en una solicitud
	has_many :how_mets

	# Devuelve true si el tipo es Otro
	def is_other?
		return self.name === "Otro"
	end
end
