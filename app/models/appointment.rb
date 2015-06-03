# == Schema Information
#
# Table name: appointments
#
#  id                :integer          not null, primary key
#  number            :integer
#  date              :datetime
#  attended          :boolean
#  notes             :text
#  patient_record_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#
class Appointment < ActiveRecord::Base

	# Expediente
	belongs_to :patient_record

	# Sintomas detectados
	has_many :symptoms, :dependent => :destroy

	# Sintomas en formularios anidados
	accepts_nested_attributes_for :symptoms, :allow_destroy => true,
	:reject_if => proc { |attrs| attrs["symptom_type_id"].blank? or attrs["level"].blank? }

end
