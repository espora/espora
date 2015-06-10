# == Schema Information
#
# Table name: experience_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class ExperienceType < ActiveRecord::Base

	# Expedientes
	has_and_belongs_to_many :patient_records
	
end
