class Therapist < ActiveRecord::Base

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	# Horarios de los terapeutas
	has_many :therapist_schedules

	# Solicitudes de paciente
	has_many :requests_received,  :class_name => 'PatientRequest', :foreign_key => 'receive_therapist_id'
	has_many :requests_contacted, :class_name => 'PatientRequest', :foreign_key => 'contact_therapist_id'

	# Expediente que atiende
	has_many :patient_records

<<<<<<< HEAD
	def matchesPatientSchedule ( patient_request )
		
		patient_request.request_schedules.each do | req_schedule |
=======
	def match_schedule? ( patient_request )

		# Iteramos todos los horarios del terapeuta
		self.therapist_schedules.each do | t_schedule |

			# Creamos el rango de tiempo
			t_begin_schedule = TimeOfDay.new(t_schedule.beginH.hour, t_schedule.beginH.min)
			t_end_schedule = TimeOfDay.new(t_schedule.endH.hour, t_schedule.endH.min)
			t_range_schedule = Shift.new(t_begin_schedule, t_end_schedule)

			# Obtenemos los del dia 
			patient_schedules = patient_request.request_schedules.where(:day => t_schedule.day)

			# Iteramos los horarios del paciente para ese día
			patient_schedules.each do | p_schedule |

				# Creamos el rango de tiempo
				p_begin_schedule = TimeOfDay.new(p_schedule.beginH.hour, p_schedule.beginH.min)
				p_end_schedule = TimeOfDay.new(p_schedule.endH.hour, p_schedule.endH.min)
				p_range_schedule = Shift.new(p_begin_schedule, p_end_schedule)

				# Preguntamos si se incluye al horario
				test1 = t_range_schedule.include?(p_begin_schedule) or t_range_schedule.include?(p_end_schedule)
				test2 = p_range_schedule.include?(t_begin_schedule) or p_range_schedule.include?(t_end_schedule) 
				if test1 or test2
					return true
				end

			end
>>>>>>> 76331f357fae5d00c6a124fcef8def5bfe41809a
		end

		return false
	end
end
