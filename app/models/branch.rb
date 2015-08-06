# == Schema Information
#
# Table name: branches
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  branch_type_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#
class Branch < ActiveRecord::Base

	# Recurso de roles
	resourcify

	# Tipo de sede
	belongs_to :branch_type

	# Carreras
	has_many :careers

	# Terapeutas
	has_many :therapists
end
