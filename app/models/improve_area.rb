# == Schema Information
#
# Table name: improve_areas
#
#  id                    :integer          not null, primary key
#  patient_signout_id    :integer
#  personal_area_type_id :integer
#  other_name            :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#
class ImproveArea < ActiveRecord::Base

	# Egreso de paciente
	belongs_to :patient_signout

	# Area personal mejorada
	belongs_to :personal_area_type
end
