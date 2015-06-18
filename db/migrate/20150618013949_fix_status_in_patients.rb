class FixStatusInPatients < ActiveRecord::Migration
	def change
		patients = Patient.all
		patients.each do |patient|
			patient_status = nil
			if patient.patient_record.nil?
				patient_status = PatientStatusType.find_by_name("Sin contactar")
			else
				patient_status = PatientStatusType.find_by_name("En tratamiento")
			end

			patient.patient_status_type = patient_status
			patient.save
		end
	end
end
