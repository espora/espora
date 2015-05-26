class RemoveHowMetFromPatientRequest2 < ActiveRecord::Migration
	def change
		remove_column :patient_requests, :how_met
	end
end
