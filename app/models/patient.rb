class Patient < ActiveRecord::Base

	# Solicitud del paciente
	has_one :patient_request, :dependent => :destroy

	# Expediente
	has_one :patient_record, :dependent => :destroy

	# Validaciones
	validates :account_number, presence: true

########################
    #t.string "p_last_name" = apellido Paterno
    validates :p_last_name, presence: { :message => "Campo vacío, ingresar el apellido paterno" }
    validates :p_last_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" } 

    #t.string   "m_last_name" = apellido Materno
    validates :m_last_name, presence: { :message => "Campo vacío, ingresar el apellido materno" }
 	validates :m_last_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" } 

    #t.string   "names" = nombres
    validates :names, presence: { :message => "Campo vacío, ingresar un(os) nombre(s)" }
    validates :names, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" } 
    validates :telephone1, length: {
    	minimum: 2,
    	maximum: 20,
    	tokenizer: lambda { |str| str.split(/\s+/) },
    	too_short: "Debe tener al menos %{count} dígitos",
    	too_long: "Debe tener a lo mas %{count} dígitos"
 	}

    #t.integer  "account_number" = numero Cuenta
    validates :account_number, presence: { :message => "Campo vacío, ingresar el numero de cuenta"}
    validates :account_number, numericality: { :only_integer => true, :message => "Tipo de dato inválido" } 
    validates :account_number, :length => { :is => 9, :message => "Tamaño incorrecto, solo se permiten 9 caractares" }
    validates :account_number, uniqueness: { :message => "No. Cuenta ya registrado" }

    #t.date     "birth" = Fecha de nacimiento
    #validates :birth,

    #t.string   "sex" = sexo
    validates :sex, presence: { :message => "Campo vacío" }
	validates :sex, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" }
	validates :sex, :inclusion => { :in => %w(f m), :message => "%{value} no es un tipo de sexo" }

    #t.string   "career" = carrera
    validates :career, presence: { :message => "Campo vacío" }
	validates :career, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato inválido, solo permite letras" }
	validates :career, :inclusion => { :in => %w(actuaria biologia ciencias_ambientales ciencias_de_la_computacion ciencias_de_la_tierra fisica_biomedica manejo_sustentable_de_zonas_costeras matematicas),
									   :message => "%{value} no es una carrera de la Facultad de Ciencias" }

    #t.string   "init_school" = año de ingreso
    validates :init_school, presence: { :message => "Campo vacío" }
    validates :init_school, numericality: { :only_integer => true, :message => "Tipo de dato inválido, solo permite enteros" } 

    #t.integer  "semester" = semestre
    validates :semester, numericality: { :only_integer => true, :message => "Tipo de dato inválido, solo permite enteros"} 
    validates :semester, length: { :is => 5	} # tengo duda con este porque dice en el form que el tamaño es 5, pero aún así tengo duda


    #t.integer  "failed_subjects" = materias Reprobadas
    validates :failed_subjects, numericality: { :only_integer => true, :message => "Tipo de dato inválido, solo permite enteros" } 

    #t.string   "telephone1" = telefono
    validates :telephone1, presence: { :message => "Campo vacío, ingresar un número telefonico" }
    validates :telephone1, numericality: { :only_integer => true, :message => "Tipo de dato inválido, solo permite enteros" } 
    validates :telephone1, length: {
    	minimum: 7,
    	maximum: 12,
    	tokenizer: lambda { |str| str.split(/\s+/) },
    	too_short: "Debe tener al menos %{count} dígitos",
    	too_long: "Debe tener a lo mas %{count} dígitos"
 	}

    #t.string   "telephone2" = celular
    validates :telephone2, numericality: { :only_integer => true, :message => "Tipo de dato inválido, solo permite enteros" } 
    validates :telephone2, length: {
    	minimum: 10,
    	maximum: 13,
    	tokenizer: lambda { |str| str.split(/\s+/) },
    	too_short: "Debe tener al menos %{count} dígitos",
    	too_long: "Debe tener a lo mas %{count} dígitos"
 	}
    #t.string   "email" 
    validates :email, presence: { :message => "Campo vacío, ingresar email" }
    VALID_CARACTERS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { :with => VALID_CARACTERS , :message => "Formato de correo inválido" }
    validates :email, uniqueness: { :case_sensitive => true, :message => "email ya registrado" }

end


