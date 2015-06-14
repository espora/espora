# == Schema Information
#
# Table name: affected_areas
#
#  id                    :integer          not null, primary key
#  patient_request_id    :integer
#  personal_area_type_id :integer
#  other_name            :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#
class AffectedArea < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de area personal afectada
	belongs_to :personal_area_type
	
end
