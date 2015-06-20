# == Schema Information
#
# Table name: patient_dropout_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class PatientDropoutType < ActiveRecord::Base

	# Baja
	has_many :patient_dropouts
	
end
