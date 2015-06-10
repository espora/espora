# == Schema Information
#
# Table name: patient_requests
#
#  id                   :integer          not null, primary key
#  reasons              :text
#  condition            :string(255)
#  money                :float
#  pre_care             :boolean
#  request_date         :date
#  attention_date       :date
#  created_at           :datetime
#  updated_at           :datetime
#  receive_therapist_id :integer
#  patient_id           :integer
#  contact_therapist_id :integer
#
class PatientRequest < ActiveRecord::Base

	# Paciente
	belongs_to :patient

	# Terapeuta que recibe la solicitud
	belongs_to :receive_therapist,  :class_name => "Therapist"

	# Terapeuta que contacta la solicitud
	belongs_to :contact_therapist,  :class_name => "Therapist"

	# Areas afectadas
	has_many :affected_areas, :dependent => :delete_all

	# Areas afectadas en formularios anidados
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true

	# Como conocio espora
	has_one :how_met, :dependent => :delete

	# Como conocio en formularios anidados
	accepts_nested_attributes_for :how_met, :allow_destroy => true

	# Horarios solicitados
	has_many :request_schedules, :dependent => :delete_all

	# Horarios solicitados en formularios anidados
	accepts_nested_attributes_for :request_schedules, :allow_destroy => true

	# Mapeo condicion a nombre en formulario
	NAME_CONDITION = {
		"mal" => "Mal",
		"muy_mal" => "Muy mal",
		"regular" => "Regular",
		"bien" => "Bien",
		"muy_bien" => "Muy bien"
	}

	# Mapeo para el orden
	CONDITION_ORDER = {
		"muy_mal" => 0,
		"mal" => 1,
		"regular" => 2,
		"bien" => 3,
		"muy_bien" => 4
	}

	# t.text "reasons"
	validates :reasons, presence: { :message => "Campo vacio" }
	validates :reasons, length: { maximum: 400,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	# t.string   "how_met"
	validates :how_met, presence: { :message => "Campo vacio" }

	# t.float "money"
	validates :money, presence: { :message => "Campo vacio" }

	# t.association "affected_areas"
	validates :affected_areas, :length => { :minimum => 1 }

	# t.association "request_schedules"
	validates :request_schedules, :length => { :minimum => 1 }
	
end
