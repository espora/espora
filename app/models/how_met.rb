class HowMet < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de como conocio
	belongs_to :how_met_type

	def isOther?
		if self.how_met_type.name == "Otro"
			return true
		else
			return false
		end
	end
end
