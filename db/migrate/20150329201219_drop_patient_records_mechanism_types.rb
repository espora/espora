class DropPatientRecordsMechanismTypes < ActiveRecord::Migration
	def change
		drop_table :patient_records_mechanism_types
	end
end
