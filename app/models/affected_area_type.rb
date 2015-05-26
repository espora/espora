class AffectedAreaType < ActiveRecord::Base

	# Areas afectadas de una solicitud
	has_many :affected_areas

	def is_other?
		if self.name == "Otro"
			return true
		else
			return false
		end
	end
end