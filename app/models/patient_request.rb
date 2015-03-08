class PatientRequest < ActiveRecord::Base

	belongs_to :patient
	belongs_to :receive_therapist,  :class_name => "Therapist"
	belongs_to :contact_therapist,  :class_name => "Therapist"

	has_many :request_schedules, :dependent => :delete_all
	has_many :affected_areas, :dependent => :delete_all

	accepts_nested_attributes_for :request_schedules, :allow_destroy => true
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true

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
		"mal" => 0,
		"muy_mal" => 1,
		"regular" => 2,
		"bien" => 3,
		"muy_bien" => 4
	}

	###### VALIDACIONES

	#t.text "reasons"
	validates :reasons, presence: { :message => "Campo vacio" }
	validates :reasons, length: { maximum: 400,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	#t.string   "condition"
	#t.string   "how_met"
	validates :how_met, presence: { :message => "Campo vacio" }
	validates :how_met, length: { maximum: 69,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	#t.float "money"
	validates :money, presence: { :message => "Campo vacio" }
end
