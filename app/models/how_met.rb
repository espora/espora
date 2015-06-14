# == Schema Information
#
# Table name: how_mets
#
#  id                 :integer          not null, primary key
#  patient_request_id :integer
#  how_met_type_id    :integer
#  other_name         :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#
class HowMet < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de como conocio
	belongs_to :how_met_type

end
