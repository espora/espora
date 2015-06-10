# == Schema Information
#
# Table name: affected_area_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class AffectedAreaType < ActiveRecord::Base

	# Areas afectadas de una solicitud
	has_many :affected_areas

	# Devuelve true si el tipo es Otro
	def is_other?
		return self.name === "Otro"
	end
end
