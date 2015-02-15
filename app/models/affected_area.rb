class AffectedArea < ActiveRecord::Base
	belongs_to :patient_request

	def isOther?
		if self.area == "Escolar" || self.area == "Familiar" || self.area == "Social" || self.area == "Laboral" || self.area == "Pareja" || self.area == "Sexual" || self.area == "Emocional"
			return false
		else
			return true
		end
	end

end
