# coding: utf-8

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

patient_entries.each do |entry|

	patient = Patient.new(entry)
	if patient.valid? 
		patient.save
	end
	puts patient.valid?
end



patient_request_entries = [

	{
		money: 300,
		pre_care: false,
		receive_therapist_id:1,
		patient: Patient.find_by_account_number(123321123),
		contact_therapist_id:1,
		condition_type_id:1
	}

]

patient_request_entries.each do |request|
	p_request = PatientRequest.new(request)
	puts p_request.valid?
end

