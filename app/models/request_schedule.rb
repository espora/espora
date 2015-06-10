# == Schema Information
#
# Table name: request_schedules
#
#  id                 :integer          not null, primary key
#  day                :integer
#  beginH             :time
#  endH               :time
#  patient_request_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#
class RequestSchedule < ActiveRecord::Base

	# Solicitud de paciente
	belongs_to :patient_request
end
