class PatientRequest < ActiveRecord::Base
	belongs_to :receive_therapist, :class_name => "Therapist"
	belongs_to :attention_therapist, :class_name => "Therapist"

	has_many :request_schedules
	has_many :affected_areas
end
