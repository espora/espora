class CreatePatientRecordsExperienceTypes < ActiveRecord::Migration
	def change
		create_table :patient_records_experience_types, id: false do |t|
			t.belongs_to :patient_record, index: true
			t.belongs_to :experience_type, index: true
		end
	end
end
