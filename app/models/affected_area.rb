class AffectedArea < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Areas afectadas
	AFFECTED_AREAS = ["Escolar", "Familiar", "Social", "Laboral", "Pareja", "Sexual", "Emocional", "Otro"]

	def isOther?
		if self.area == "Escolar" || self.area == "Familiar" || self.area == "Social" || self.area == "Laboral" || self.area == "Pareja" || self.area == "Sexual" || self.area == "Emocional"
			return false
		else
			return true
		end
	end

end
