# == Schema Information
#
# Table name: advise_level_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class AdviseLevelType < ActiveRecord::Base

	# Egresos
	has_many :patient_signouts

end
