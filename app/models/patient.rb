# == Schema Information
#
# Table name: patients
#
#  id                     :integer          not null, primary key
#  p_last_name            :string(255)
#  m_last_name            :string(255)
#  names                  :string(255)
#  account_number         :integer
#  birth                  :date
#  sex                    :string(255)
#  init_school            :string(255)
#  semester               :integer
#  failed_subjects        :integer
#  telephone1             :string(255)
#  telephone2             :string(255)
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  patient_status_type_id :integer
#  career_id              :integer
#
class Patient < ActiveRecord::Base

	# Estatus
	belongs_to :patient_status_type

	# Solicitud del paciente
	has_one :patient_request, :dependent => :destroy

	# Expediente
	has_one :patient_record, :dependent => :destroy

	# Baja
	has_one :patient_dropout, :dependent => :destroy

	# Carrera
	belongs_to :career

	# Mapeo del sexo
	NAME_SEX = {
		"m" => "Masculino",
		"f" => "Femenino"
	}

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

	# Regresa el nombre completo del paciente:
	#  ApellidoPaterno ApellidoMaterno Nombres
	def full_name
		self.p_last_name + " " + self.m_last_name + " " + self.names
	end

	# Devuelve la edad del paciente a partir de
	# su fecha de nacimiento
	def age

		# Obtenemos su fecha de nacimiento
		birthday = self.birth

		# Obtiene la fecha actual
		now = Time.now.utc.to_date

		# Regresa la diferencia de años con excedente
		return now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
	end
end
