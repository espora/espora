class DestroyPatientRequestsReasonsTypes < ActiveRecord::Migration
	def change
		drop_table :patient_requests_reasons_types
	end
end
