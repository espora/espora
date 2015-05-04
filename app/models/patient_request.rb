class PatientRequest < ActiveRecord::Base

	# Paciente
	belongs_to :patient

	# Terapeuta que recibe la solicitud
	belongs_to :receive_therapist,  :class_name => "Therapist"

	# Terapeuta que contacta la solicitud
	belongs_to :contact_therapist,  :class_name => "Therapist"

	# Horarios solicitados
	has_many :request_schedules, :dependent => :delete_all

	# Areas afectadas
	has_many :affected_areas, :dependent => :delete_all

	# Horarios solicitados en formularios anidados
	accepts_nested_attributes_for :request_schedules, :allow_destroy => true
	#:reject_if => proc { |attrs| attrs["symptom_type_id"].blank? or attrs["level"].blank? }

	# Areas afectadas en formularios anidados
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true
	#:reject_if => proc { |attrs| attrs["symptom_type_id"].blank? or attrs["level"].blank? }

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

	###### VALIDACIONES

	# t.text "reasons"
	validates :reasons, presence: { :message => "Campo vacio" }
	validates :reasons, length: { maximum: 400,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	# t.string   "condition"
	# t.string   "how_met"
	validates :how_met, presence: { :message => "Campo vacio" }
	validates :how_met, length: { maximum: 69,
	too_long: "%{count} es el maximo de caracteres que se pueden ingresar" }

	# t.float "money"
	validates :money, presence: { :message => "Campo vacio" }

	# t.association "affected_areas"
	validates :affected_areas, :length => { :minimum => 1 }

	# t.association "request_schedules"
	validates :request_schedules, :length => { :minimum => 1 }

end
