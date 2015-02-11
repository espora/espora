class Patient < ActiveRecord::Base

	# Solicitud del paciente
	has_one :patient_request, :dependent => :destroy

	# Expediente
	has_one :patient_record, :dependent => :destroy

	# Validaciones
	validates :account_number, presence: true

end
