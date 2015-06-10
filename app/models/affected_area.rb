# == Schema Information
#
# Table name: affected_areas
#
#  id                    :integer          not null, primary key
#  patient_request_id    :integer
#  created_at            :datetime
#  updated_at            :datetime
#  other_name            :string(255)
#  affected_area_type_id :integer
#
class AffectedArea < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de area afectada
	belongs_to :affected_area_type
	
end
