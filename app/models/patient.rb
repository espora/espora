class Patient < ActiveRecord::Base

	# Solicitud del paciente
	has_one :patient_request, :dependent => :destroy

	# Expediente
	has_one :patient_record, :dependent => :destroy

	# Mapeo condicion a nombre en formulario
	NAME_CAREER = {
		"actuaria" => "Actuaría", 
		"biologia" => "Biología", 
		"ciencias_ambientales" => "Ciencias Ambientales", 
		"ciencias_de_la_computacion" => "Ciencias de la Computación",
		"ciencias_de_la_tierra" => "Ciencias de la Tierra", 
		"fisica" => "Física",
		"fisica_biomedica" => "Fisica Biomédica",
		"manejo_sustentable_de_zonas_costeras" => "Manejo Sustentable de Zonas Costeras",
		"matematicas" => "Matemáticas"
	}

	# Mapeo del sexo
	NAME_SEX = {
		"m" => "Masculino",
		"f" => "Femenino"
	}

	# Mapeo de nombres de status
	NAME_STATUS = {
		"uncontacted" => "Sin contactar",
		"waiting" => "Esperando respuesta",
		"treatment" => "En tratamiento",
		"uninterested" => "Ya no esta interesado",
		"interrupted_treatment" => "Tratamiento interrumpido",
		"redirected" => "Canalizado",
		"ended" => "Finalizado",
		"abandoned_treatment" => "Tratamiento abandonado"
	}

	# Mapeo para el orden del status
	STATUS_ORDER = {
		"uncontacted" => 0,
		"waiting" => 1,
		"treatment" => 2,
		"uninterested" => 3,
		"interrupted_treatment" => 4,
		"redirected" => 5,
		"ended" => 6,
		"abandoned_treatment" => 7
	}

	###### VALIDACIONES

	# t.string   "p_last_name"
	VALID_CARACTERS_SPANISH = /(\A[A-Za-z\sÁÉÍÓÚáéíóúñÑ]+\z)/
	validates :p_last_name, presence: { :message => "Ingresar el apellido paterno" }
	validates :p_last_name, format: { :with => VALID_CARACTERS_SPANISH, :message => "Formato invalido, solo permite letras" }

	# t.string   "m_last_name"
	validates :m_last_name, presence: { :message => "Ingresar el apellido materno" }
	validates :m_last_name, format: { :with => VALID_CARACTERS_SPANISH, :message => "Formato invalido, solo permite letras" }

	# t.string   "names"
	validates :names, presence: { :message => "Ingresar un(os) nombre(s)" }
	validates :names, format: { :with => VALID_CARACTERS_SPANISH, :message => "Formato invalido, solo permite letras" }

	# t.integer  "account_number"
	validates :account_number, presence: { :message => "Ingresar el numero de cuenta"}
	validates :account_number, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 
	validates :account_number, length: { is: 9 }
	validates :account_number, uniqueness: { message: "Número de Cuenta ya registrado" }

	# t.date "birth"
	validates :birth, presence: { :message => "Campo vacio" }

	# t.string   "sex"
	validates :sex, presence: { :message => "Campo vacio" }

	# t.string   "career"
	validates :career, presence: { :message => "Campo vacio" }

	# t.string   "init_school"
	validates :init_school, presence: { :message => "Campo vacio" }

	# t.integer  "semester"
	validates :semester, numericality: { only_integer: true, :message => "Tipo de dato invalido"}, presence: { :message => "Campo vacio" }

	# t.integer  "failed_subjects"
	validates :failed_subjects, numericality: { only_integer: true, :message => "Tipo de dato invalido" } 

	# t.string   "telephone1" : telefono
	validates :telephone1, numericality: { only_integer: true, :allow_nil => true, :message => "Tipo de dato invalido" } 
	validates :telephone1, length: {
		allow_nil: true,
		minimum: 8,
		maximum: 13,
		too_short: "Debe tener al menos %{count} digitos",
		too_long: "Debe tener a lo mas %{count} digitos"
	}

	# t.string   "email"
	validates :email, presence: { :message => "Ingresar email" }
	VALID_CARACTERS = /\A([0-9A-Za-z\-\.\_]+)\@[a-z]+\.[a-z]+\z/
	validates :email, format: { :with => VALID_CARACTERS , message: "Formato de correo invalido" }
	validates :email, uniqueness: { case_sensitive: true, message: "Correo electrónico ya registrado" }

	###### METODOS

	# Devuelve las opciones disponibles para
	# carrera
	def self.carrer_options
		options = []
		i = 0
		Patient::NAME_CAREER.each do |key, value|
			options[i] = [value, key]
			i += 1
		end

		return options
	end

	# Devuelve las opciones disponibles para inicio
	# de año escolar
	def self.init_school_years
		bYear = 1990
		eYear = 2015
		options = []
		i = 0
		(bYear..eYear).each do |year|
			options[i] = [year.to_s, year.to_s]
			i += 1
		end

		return options
	end

	def full_name
		self.p_last_name + " " + self.m_last_name + " " + self.names
	end

	def next_appointment_date
		""
	end

end
