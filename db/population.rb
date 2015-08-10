# coding: utf-8

# -----> PACIENTES <-----

require "faker"

# Numero de pacientes que se intenta crear
n_patients = 100
puts "\n--- Intentando poblar la tabla Pacientes con #{n_patients} inserciones... "

# Creamos un arreglo con los pacientes creadoss
patients_created = Array.new

# Iteramos la cantidad de veces que queremos crear información de pacientes
n_patients.times do |n|

	# Generamos un numero de cuenta
	account_number = Faker::Number.number(9).to_i
	if account_number.to_s.size < 9
		diff = 9 - account_number.to_s.size
		account_number = account_number * (10 ** diff)
	end

	# Si el numero de cuenta no ha sido metido
	if Patient.find_by_account_number(account_number).nil?

		# Generamos una entrada de paciente
		patient = Patient.new({
			account_number: account_number,
			p_last_name: Faker::Name.last_name,
			m_last_name: Faker::Name.last_name,
			names: Faker::Name.first_name,
			birth: Faker::Date.between(45.years.ago, 25.years.ago),
			sex: ["m", "f"].sample,
			career_id: [1, 2, 3, 4, 5, 6, 7, 8].sample,
			init_school: Faker::Number.between(from=1990, to=2015),
			semester: Faker::Number.between(from=1, to=8),
			failed_subjects: Faker::Number.between(from=1, to=5),
			telephone1: Faker::Number.number(8),
			telephone2: Faker::Number.number(10),
			email: Faker::Internet.free_email,
			patient_status_type_id: [1, 2].sample
		})

		# Si es valido lo guardamos
		if patient.valid?
			patient.save
			patients_created << patient
		end
	end
end

puts "   #{patients_created.size} inserciones hechas a la tabla de Pacientes."

# -----> SOLICITUDES DE PACIENTE <-----

# Solicitudes creadas
requests_created = Array.new

puts "\n--- Intentando poblar la tabla Solicitudes con #{patients_created.count} inserciones... "

# Creamos una solicitud para cada 
patients_created.each do |patient|
	if patient.patient_request.nil?

		# Generamos la entrada de la solicitud
		patient_request = PatientRequest.new({
			money: Faker::Number.between(from=0, to=500),
			pre_care: [true, false].sample,
			request_date: Faker::Date.between(30.days.ago, Date.today),
			attention_date: Faker::Date.forward(10),
			patient_id: patient.id,
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
		})

		if patient_request.valid?
			patient_request.save
			requests_created << patient_request
		end
	end
end

puts "   #{requests_created.size} inserciones hechas a la tabla de Solicitudes."
