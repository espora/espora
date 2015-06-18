# == Schema Information
#
# Table name: patient_status_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class PatientStatusType < ActiveRecord::Base

	# Paciente
	has_many :patients
	
end
