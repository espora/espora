# == Schema Information
#
# Table name: branch_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
class BranchType < ActiveRecord::Base

	# Sede
	has_many :branches
end