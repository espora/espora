# coding: utf-8

# -----> PACIENTES <-----

require 'faker'

# Numero de pacientes que se crearan
n_patients = 1

# Creamos los arreglos que necesitamos para las entradas de los pacientes
account_numbers = Array.new
patient_entries = Array.new

# Iteramos la cantidad de veces que queremos crear información de pacientes
n_patients.times do |n|

	# Guardamos la información de los números de cuenta en el arreglo de entradas para pacientes
	account_numbers << Faker::Number.number(9)

	entry = {
		account_number: account_numbers.last,
		p_last_name: Faker::Name.last_name,
		m_last_name: Faker::Name.last_name,
		names: Faker::Name.first_name,
		birth: Faker::Date.between(45.years.ago, 25.years.ago),
		sex: ["m", "f"].sample,
		career: ["actuaria","biologia","ciencias_ambientales","ciencias_de_la_computacion","ciencias_de_la_tierra","fisica","fisica_biomédica","manejo_sustentable_de_zonas_costeras","matematicas"].sample,
		init_school: Faker::Number.between(from=1990, to=2015),
		semester: Faker::Number.between(from=1, to=8),
		failed_subjects: Faker::Number.between(from=1, to=5),
		telephone1: Faker::Number.number(8),
		telephone2: Faker::Number.number(10),
		email: Faker::Internet.free_email,
		patient_status_type_id: Faker::Number.between(from=1, to=5)
	}

	# Guardamos todas las entradas en el arreglo original 
	patient_entries << entry
end

# Mensaje que describe la acción a realizar
puts "\n--- Poblando tabla Pacientes con (#{patient_entries.count} inserciones)... "

#Contamos el número de pacientes que se introducirán
before_count = Patient.count

#Iteramos para comprobar que el registro exista
patient_entries.each do | entry |

	# Si no existe guardamos el registro
	if Patient.find_by_account_number(entry[:account_number]).nil?
		patient = Patient.new(entry)

		if patient.valid?
			patient.save
		end
	end
end

# Mensaje que describe la acción realizada
puts "   #{Patient.count - before_count} inserciones hechas al catálogo de Estatus de Paciente."

# -----> SOLICITUDES DE PACIENTE <-----

request_entries = Array.new

n_patients.times do |n|

	
entry = {
		money: Faker::Number.between(from=0, to=500),
		pre_care: [true, false].sample,
		request_date: Faker::Date.between(30.days.ago, Date.today),
		attention_date: Faker::Date.forward(10),
		patient_id: Patient.find_by_account_number(account_numbers).id,
		contact_therapist_id: Therapist.last.id,
		receive_therapist_id: Therapist.last.id,
		condition_type_id: Faker::Number.between(from=1, to=5),
		reasons: [
			Reason.new(reasons_type_id: Faker::Number.between(from=1, to=23))
		],
		how_met: HowMet.new(how_met_type_id: Faker::Number.between(from=1, to=5)),
		affected_areas: [
			AffectedArea.new(personal_area_type_id: Faker::Number.between(from=1, to=7))
		],
		request_schedules: [
			RequestSchedule.new(day: Faker::Number.between(from=1, to=5), beginH: Faker::Time.forward(10), endH: Faker::Time.forward(10))
		]
	}

request_entries << entry

end

puts "\n--- Poblando tabla Solicitudes con (#{request_entries.count} inserciones)... "


before_count = PatientRequest.count
request_entries.each do | entry |

	patient = Patient.find(entry[:patient_id])
	if patient.patient_request.nil?

		patient_request = PatientRequest.new(entry)
		if patient_request.valid?
			patient_request.save
		end

		if not patient_request.valid?
			ap patient_request.errors
		end
	end
end
