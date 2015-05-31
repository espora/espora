class AffectedArea < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de area afectada
	belongs_to :affected_area_type
	
end