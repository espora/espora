class PatientRequest < ActiveRecord::Base

	belongs_to :patient
	belongs_to :receive_therapist,   :class_name => "Therapist"
	belongs_to :attention_therapist, :class_name => "Therapist"

	has_many :request_schedules, :dependent => :delete_all
	has_many :affected_areas, :dependent => :delete_all

	accepts_nested_attributes_for :request_schedules, :allow_destroy => true
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true

end
