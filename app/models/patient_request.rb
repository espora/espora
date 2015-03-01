class PatientRequest < ActiveRecord::Base

	belongs_to :patient
	belongs_to :receive_therapist,  :class_name => "Therapist"
	belongs_to :contact_therapist,  :class_name => "Therapist"

	has_many :request_schedules, :dependent => :delete_all
	has_many :affected_areas, :dependent => :delete_all

	accepts_nested_attributes_for :request_schedules, :allow_destroy => true
	accepts_nested_attributes_for :affected_areas, :allow_destroy => true

#######################

	#t.text     "reasons" = motivosls
	validates :reasons, length: { maximum: 400,
    too_long: "%{count} es el máximo de caracteres que se pueden ingresar" }

    #t.string   "condition" = condición
    validates :condition, presence: { :message => "Campo vacío, ingresar una condición" }
    validates :condition, format: { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" } 
    validates :condition, inclusion: { :in => %w(muy_mal mal regular bien muy_bien), :message => "%{value} no es una condición de paciente"}

    #t.string   "how_met" = modoConocio
    validates :how_met, presence: { :message => "Campo vacío, ingresar como conocio" }
    validates :how_met, length: { maximum: 50, 
    too_long: "%{count} es el máximo de caracteres que se pueden ingresar" }
    
    #t.float    "money" = dineroGasto
    validates :money, numericality: { :only_integer => true }
    validates :money, length: { maximum: 6, 
    too_long: "%{count} es el máximo de caracteres que se pueden ingresar"}

    #t.boolean  "pre_care" = atnPrevia
    validates :pre_care, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" }
	validates :pre_care, :inclusion => { :in => %w(s n), :message => "%{value} no es un tipo de valor permitido" }

end
