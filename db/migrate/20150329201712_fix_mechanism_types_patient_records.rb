class FixMechanismTypesPatientRecords < ActiveRecord::Migration
	def change
		drop_table :mechanism_types_patient_records
		create_table :mechanism_types_patient_records, id: false do |t|
			t.belongs_to :mechanism_type, index: true
			t.belongs_to :patient_record, index: true
		end
	end
end
