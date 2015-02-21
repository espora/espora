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

	#t.text "reasons"
	validates :reasons, length: { maximum: 400,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	#t.string   "condition"
	#t.string   "how_met"
	validates :how_met, length: { maximum: 69,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }
	
	#t.float	"money"
	validates :money, numericality: { only_integer: true }

	#t.boolean  "pre_care"
	#t.date	 "request_date"
	#t.date	 "attention_date"
	#t.datetime "created_at"
	#t.datetime "updated_at"
	#t.integer  "receive_therapist_id"
	#t.integer  "attention_therapist_id"
	#t.integer  "patient_id"

end
