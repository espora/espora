class HowMetType < ActiveRecord::Base

	# Areas afectadas de una solicitud
	has_many :how_mets

	def is_other?
		if self.name == "Otro"
			return true
		else
			return false
		end
	end
end
