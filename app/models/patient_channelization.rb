# == Schema Information
#
# Table name: patient_channelizations
#
#  id                 :integer          not null, primary key
#  where              :string(255)
#  patient_dropout_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class PatientChannelization < ActiveRecord::Base

	# Baja de paciente
	belongs_to :patient_dropout
	
end
