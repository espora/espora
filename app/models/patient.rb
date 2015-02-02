class Patient < ActiveRecord::Base

	has_one :patient_request, :dependent => :destroy

	# Validaciones
	validates :account_number, presence: true

end
