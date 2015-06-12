class FixConditionInPatientRequest < ActiveRecord::Migration
	def change
		remove_column :patient_requests, :condition
		add_column :patient_requests, :condition_type_id, :integer, references: :condition_types
	end
end
