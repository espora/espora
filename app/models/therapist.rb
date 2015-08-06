# == Schema Information
#
# Table name: therapists
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  scholar_grade          :string(255)
#  telephone1             :string(255)
#  telephone2             :string(255)
#  p_last_name            :string(255)
#  m_last_name            :string(255)
#  names                  :string(255)
#  branch_id              :integer
#
class Therapist < ActiveRecord::Base

	# Roles
	rolify

	# Sistema de login
	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	# Horarios de los terapeutas
	has_many :therapist_schedules, :dependent => :delete_all

	# Horarios de los terapeutas en formularios anidados
	accepts_nested_attributes_for :therapist_schedules, :allow_destroy => true

	# Solicitudes de paciente
	has_many :requests_received,  :class_name => 'PatientRequest', :foreign_key => 'receive_therapist_id'
	has_many :requests_contacted, :class_name => 'PatientRequest', :foreign_key => 'contact_therapist_id'

	# Expediente que atiende
	has_many :patient_records

	# Sede a la que pertenece
	belongs_to :branch

	# Verifica si un terapeuta tiene en común algún horario
	# de una solicitud. Es decir, si algún horario solicitado
	# se empata con alguno de sus horarios
	def match_schedule? (patient_request)

		# Obtenemos los horarios del terapeuta acomodados por dias
		ther_days = [ Array.new,  Array.new,  Array.new,  Array.new,  Array.new ]
		ther_schedules = self.therapist_schedules.order('day asc')
		ther_schedules.each do | ther_schedule |
			ther_days[ther_schedule.day - 1] << ther_schedule
		end

		# Obtenemos los horarios del paciente acomodados por dias
		pat_days = [ Array.new,  Array.new,  Array.new,  Array.new,  Array.new ]
		pat_schedules = patient_request.request_schedules.order('day asc')
		pat_schedules.each do | pat_schedule |
			pat_days[pat_schedule.day - 1] << pat_schedule
		end

		# Iteramos los días
		5.times do | day |

			# Si hay coincidencias en dias
			if not ther_days[day - 1].empty? and not pat_days[day - 1].empty?

				# Checamos las horas
				ther_days[day - 1].each do | ther_schedule |

					# Creamos el rango de tiempo
					ther_begin_schedule = TimeOfDay.new(ther_schedule.beginH.hour, ther_schedule.beginH.min)
					ther_end_schedule = TimeOfDay.new(ther_schedule.endH.hour, ther_schedule.endH.min)
					ther_range_schedule = Shift.new(ther_begin_schedule, ther_end_schedule)

					# Iteramos los horarios del paciente para ese día
					pat_days[day - 1].each do | pat_schedule |

						# Creamos el rango de tiempo
						pat_begin_schedule = TimeOfDay.new(pat_schedule.beginH.hour, pat_schedule.beginH.min)
						pat_end_schedule = TimeOfDay.new(pat_schedule.endH.hour, pat_schedule.endH.min)
						pat_range_schedule = Shift.new(pat_begin_schedule, pat_end_schedule)

						# Preguntamos si se incluye al horario
						test  = ther_range_schedule.include?(pat_begin_schedule) or
								ther_range_schedule.include?(pat_end_schedule) or
								pat_range_schedule.include?(ther_begin_schedule) or
								pat_range_schedule.include?(ther_end_schedule)
						if test
							return true
						end
					end
				end
			end
		end

		return false
	end

	# Regresa el nombre completo del paciente:
	#  ApellidoPaterno ApellidoMaterno Nombres
	def full_name
		self.p_last_name + " " + self.m_last_name + " " + self.names
	end

	# Regresa el numero de pestañas que existen
	# en la interfaz
	def tabs_count

		# Coordinador
		if self.has_role? :coordinator
			return 5

		# Terapeuta
		else
			return 4
		end
	end

	# Regresa el nombre del rol que tiene
	def role

		# Coordinador
		if self.has_role? :coordinator
			return "Coordinador"

		# Terapeuta
		else
			return "Terapeuta"
		end
	end
end
