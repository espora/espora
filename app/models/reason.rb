# == Schema Information
#
# Table name: reasons
#
#  id                 :integer          not null, primary key
#  other_name         :string(255)
#  patient_request_id :integer
#  reasons_type_id    :integer
#  created_at         :datetime
#  updated_at         :datetime
#
class Reason < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request

	# Tipo de motivo de consulta
	belongs_to :reasons_type
	
end
