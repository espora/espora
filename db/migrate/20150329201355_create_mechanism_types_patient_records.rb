class CreateMechanismTypesPatientRecords < ActiveRecord::Migration
	def change
		create_table :mechanism_types_patient_records do |t|
			t.integer :mechanism_type_id
			t.integer :patient_record_id
		end
	end
end
