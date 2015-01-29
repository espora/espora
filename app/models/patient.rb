class Patient < ActiveRecord::Base

	has_one :patient_request, :dependent => :destroy
	
end
