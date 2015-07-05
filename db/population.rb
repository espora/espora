# coding: utf-8

# -----> PACIENTES <-----

patient_entries = [
	{
		p_last_name: "Ahumada",
		m_last_name: "Ábrego",
		names: "Jorge Alberto",
		account_number: 123321123,
		birth: "1990-12-04",
		sex: "Masculino",
		career: "Actuaria",
		init_school: 2010,
		semester: 8,
		failed_subjects: 0,
		telephone1: "56419371",
		telephone2: "5591979225",
		email: "jorge@gmail.com",
		patient_status_type_id: 1
	}
]

puts "\n--- Poblando tabla Pacientes con (#{patient_entries.count} inserciones)... "

before_count = Patient.count
patient_entries.each do | entry |

	# Si no existe
	if Patient.find_by_account_number(entry[:account_number]).nil?
		patient = Patient.new(entry)
		if patient.valid?
			patient.save
		end
	end
end

puts "   #{Patient.count - before_count} inserciones hechas al catálogo de Estatus de Paciente."

# -----> SOLICITUDES DE PACIENTE <-----

patient_request_entries = [
	{
		money: 300,
		pre_care: false,
		request_date: Time.now.to_date,
		attention_date: nil,
		patient_id: Patient.find_by_account_number(123321123).id,
		contact_therapist_id: Therapist.last.id,
		receive_therapist_id: Therapist.last.id,
		condition_type_id: 1,
		reasons: [
			Reason.new(reasons_type_id: 5)
		],
		how_met: HowMet.new(how_met_type_id: 2),
		affected_areas: [
			AffectedArea.new(personal_area_type_id: 5)
		],
		request_schedules: [
			RequestSchedule.new(day: 1, beginH: "2001", endH: "")
		]
	}
]

puts "\n--- Poblando tabla Solicitudes con (#{patient_request_entries.count} inserciones)... "


before_count = PatientRequest.count
patient_request_entries.each do | entry |

	patient = Patient.find(entry[:patient_id])
	if patient.patient_request.nil?

		patient_request = PatientRequest.new(entry)
		puts patient_request.valid?
		if not patient_request.valid?
			ap patient_request.errors
		end
	end
end
