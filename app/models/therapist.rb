class Therapist < ActiveRecord::Base

	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

	# Horarios de los terapeutas
	has_many :therapist_schedules

	# Solicitudes de paciente
	has_many :requests_received,  :class_name => 'PatientRequest', :foreign_key => 'receive_therapist_id'
	has_many :requests_contacted, :class_name => 'PatientRequest', :foreign_key => 'contact_therapist_id'

	# Expediente que atiende
	has_many :patient_records

	def match_schedule? ( patient_request )

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
end
