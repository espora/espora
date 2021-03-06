# == Schema Information
#
# Table name: patient_dropouts
#
#  id                      :integer          not null, primary key
#  patient_dropout_type_id :integer
#  patient_id              :integer
#  created_at              :datetime
#  updated_at              :datetime
#
class PatientDropout < ActiveRecord::Base

	# Paciente
	belongs_to :patient

	# Tipo de baja
	belongs_to :patient_dropout_type

	# Egreso
	has_one :patient_signout, :dependent => :destroy

	# Canalizacion
	has_one :patient_channelization, :dependent => :destroy
	
end
