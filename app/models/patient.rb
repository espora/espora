class Patient < ActiveRecord::Base

	# Solicitud del paciente
	has_one :patient_request, :dependent => :destroy

	# Expediente
	has_one :patient_record, :dependent => :destroy

	# Validaciones
	validates :account_number, presence: true

########################
	#t.string   "p_last_name"
	validates :p_last_name, presence: { :message => "Ingresar el apellido paterno" }
	validates :p_last_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato invalido, solo permite letras" } 

	#t.string   "m_last_name"
	validates :m_last_name, presence: { :message => "Ingresar el apellido materno" }
 	validates :m_last_name, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato invalido, solo permite letras" } 

	#t.string   "names"
	validates :names, presence: { :message => "Ingresar un(os) nombre(s)" }
	validates :names, :format => { :with => /\A[a-zA-Z]+\z/, :message => "Formato invalido, solo permite letras" } 

	#t.integer  "account_number"
	validates :account_number, presence: { :message => "Ingresar el numero de cuenta"}
	validates :account_number, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 
	validates :account_number, :length => { is: 9 }
	validates :account_number, uniqueness: { message: "No. Cuenta ya registrado" }

	#t.date "birth"
	#validates :birth,

	#t.integer  "age"
	#validates :age,

	#t.string   "sex"
	validates :sex, presence: { :message => "Campo vacio" }

	#t.string   "career"
	validates :career, presence: { :message => "Campo vacio" }

	#t.string   "init_school"
	validates :init_school, presence: { :message => "Campo vacio" }

	#t.integer  "semester"
	validates :semester, numericality: { only_integer: true, :message => "Tipo de dato invalido"} 

	#t.integer  "failed_subjects"
	validates :failed_subjects, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 

	#t.string   "telephone1" : telefono
	validates :telephone1, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 
	validates :telephone1, length: {
		minimum: 7,
		maximum: 12,
		tokenizer: lambda { |str| str.split(/\s+/) },
		too_short: "Debe tener al menos %{count} digitos",
		too_long: "Debe tener a lo mas %{count} digitos"
 	}

	#t.string   "telephone2" : celular
	validates :telephone2, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 
	   validates :telephone2, length: {
		minimum: 10,
		maximum: 13,
		tokenizer: lambda { |str| str.split(/\s+/) },
		too_short: "Debe tener al menos %{count} digitos",
		too_long: "Debe tener a lo mas %{count} digitos"
 	}

	#t.string   "email"
	validates :email, presence: { :message => "Ingresar email" }
	VALID_CARACTERS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { :with => VALID_CARACTERS , message: "Formato de correo invalido" }
	validates :email, uniqueness: { case_sensitive: true, message: "email ya se registrado" }

	#t.string   "status"
	#validates :status,

	#t.datetime "created_at"
	#validates :created_at,

	#t.datetime "updated_at"
	#validates :updated_at,

end
