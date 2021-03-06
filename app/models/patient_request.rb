# == Schema Information
#
# Table name: patient_requests
#
#  id                   :integer          not null, primary key
#  money                :float
#  pre_care             :boolean
#  request_date         :date
#  attention_date       :date
#  created_at           :datetime
#  updated_at           :datetime
#  receive_therapist_id :integer
#  patient_id           :integer
#  contact_therapist_id :integer
#  condition_type_id    :integer
#

class PatientRequest < ActiveRecord::Base

	# Paciente
	belongs_to :patient

	# Terapeuta que recibe la solicitud
	belongs_to :receive_therapist,  :class_name => "Therapist"

	# Terapeuta que contacta la solicitud
	belongs_to :contact_therapist,  :class_name => "Therapist"

	# Motivos de consulta
	has_many :reasons, :dependent => :delete_all

	# Motivos de consulta en formularios anidados
	accepts_nested_attributes_for :reasons, :allow_destroy => true	

	# Areas afectadas
	has_many :affected_areas, :dependent => :delete_all

	# Areas afectadas en formularios anidados
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true

	# Como conocio espora
	has_one :how_met, :dependent => :delete

	# Condicion
	belongs_to :condition_type

	# Como conocio en formularios anidados
	accepts_nested_attributes_for :how_met, :allow_destroy => true

	# Horarios solicitados
	has_many :request_schedules, :dependent => :delete_all

	# Horarios solicitados en formularios anidados
	accepts_nested_attributes_for :request_schedules, :allow_destroy => true

	# t.association "reasons"
	validates :reasons, :length => { :minimum => 1 }

	# t.association "how_met"
	validates :how_met, :length => { :minimum => 1}

	# t.float "money"
	validates :money, presence: { :message => "Campo vacio" }

	# t.association "affected_areas"
	validates :affected_areas, :length => { :minimum => 1 }

	# t.association "request_schedules"
	validates :request_schedules, :length => { :minimum => 1 }
	
end
