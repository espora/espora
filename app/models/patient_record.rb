# == Schema Information
#
# Table name: patient_records
#
#  id                         :integer          not null, primary key
#  observations               :text
#  lives_with                 :text
#  patient_id                 :integer
#  therapist_id               :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  cie10_type_id              :integer
#  clinical_structure_type_id :integer
#
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

	# Devuelve el numero para una cita nueva (consecutivo del último)
	def new_appointment_number

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

	# Obtiene la proxima cita
	def next_appointment

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

		return next_appointment
	end

	# Devuelve la fecha de la próxima cita
	def next_appointment_date

		# Obtenemos la próxima cita
		next_appointment = self.next_appointment

		if next_appointment.nil?

			# Si es nula (no hay citas)
			return "No se ha programado ninguna cita."
		else

			# Creamos la fecha y hora
			date = next_appointment.date.strftime("%d-%m-%y")
			time = next_appointment.date.strftime("%H:%M")

			return date + " " + time
		end
	end

	# Devuelve las citas que el paciente no asistio
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
