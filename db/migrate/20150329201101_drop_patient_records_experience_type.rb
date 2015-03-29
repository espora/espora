class DropPatientRecordsExperienceType < ActiveRecord::Migration
	def change
		drop_table :patient_records_experience_types
	end
end
