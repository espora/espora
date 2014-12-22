class Therapist < ActiveRecord::Base
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	has_many :therapist_schedules

	has_many :requests_received, :class_name => 'PatientRequest', :foreign_key => 'receive_therapist_id'
	has_many :requests_attended, :class_name => 'PatientRequest', :foreign_key => 'attention_therapist_id'
end
