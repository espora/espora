# == Schema Information
#
# Table name: therapist_schedules
#
#  id           :integer          not null, primary key
#  day          :integer
#  beginH       :time
#  endH         :time
#  therapist_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
class TherapistSchedule < ActiveRecord::Base

	# Terapeuta
	belongs_to :therapist
	
end