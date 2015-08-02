# == Schema Information
#
# Table name: careers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  branch_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
class Career < ActiveRecord::Base

	# Sede
	belongs_to :branch

	# Pacientes
	has_many :patients
end
