class CreateExperienceTypesPatientRecords < ActiveRecord::Migration
	def change
		create_table :experience_types_patient_records, id: false do |t|
			t.belongs_to :experience_type, index: true
			t.belongs_to :patient_record, index: true
		end
	end
end
