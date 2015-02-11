class CreatePatientRecordMechanismType < ActiveRecord::Migration
	def change
		create_table :patient_records_mechanism_types, id: false do |t|
			t.belongs_to :patient_record, index: true
			t.belongs_to :mechanism_type, index: true
		end
	end
end
