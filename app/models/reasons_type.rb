# == Schema Information
#
# Table name: reasons_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class ReasonsType < ActiveRecord::Base

	# Solicitud de paciente
	has_and_belongs_to_many :patient_requests
	
end
