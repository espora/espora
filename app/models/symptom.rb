# == Schema Information
#
# Table name: symptoms
#
#  id              :integer          not null, primary key
#  symptom_type_id :integer
#  level           :integer
#  appointment_id  :integer
#  created_at      :datetime
#  updated_at      :datetime
#
class Symptom < ActiveRecord::Base

	# Cita
	belongs_to :appointment

	# Tipo de sintoma
	belongs_to :symptom_type

end
