class PatientRecord < ActiveRecord::Base

	# Paciente al que pertenece el expediente
	belongs_to :patient

	# Terapeuta que atiende el expediente
	belongs_to :therapist

	# Clasificacion internacional de enfermedades, decima version
	belongs_to :cie10_type

	# Estructura clinica
	belongs_to :clinical_structure_type

	# Citas
	has_many :appointments, :dependent => :destroy

	# Rasgos de los padres
	has_many :paternal_traits, :dependent => :destroy
	accepts_nested_attributes_for :paternal_traits, :allow_destroy => true

	# Mecanismos
	has_and_belongs_to_many :mechanism_types

	# Situaciones y experiencias
	has_and_belongs_to_many :experience_types

	def next_appointment_number

		# Es la primera cita
		if self.appointments.count == 0
			return 1
		else
			# Obtenemos el ultimo numero
			last_number = self.appointments.order("number DESC").first.number

			# Regresamos uno mas
			return last_number + 1
		end
	end

	def next_appointment_date

		# Obtenemos la hora y fecha actual
		now = Time.now

		# Obtenemos las citas
		appointments = self.appointments

		# Iteramos buscando la minima diferencia
		next_appointment = nil
		min_diff = -1
		appointments.each do | appointment |

			# Obtenemos la diferencia en el tiempo
			diff = appointment.date - now

			# Tomamos las diferencias positivas
			if diff >= 0

				# y nos quedamos con la menor
				if next_appointment.nil? or diff < min_diff
					next_appointment = appointment
					min_diff = diff
				end
			end
		end

		date = next_appointment.date.strftime("%d-%m-%y")
		time = next_appointment.date.strftime("%H:%M")
		return date + " " + time
	end

	def missed_appointments

		# Creamos el arreglo para las inasistencias
		missed = Array.new

		# Iteramos las citas
		appointments = self.appointments
		appointments.each do | appointment |

			# Si se marco que no asistio agregamos
			if not appointment.attended.nil? and not appointment.attended
				missed << appointment
			end
		end

		return missed
	end
end
