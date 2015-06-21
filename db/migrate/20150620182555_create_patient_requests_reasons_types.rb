class CreatePatientRequestsReasonsTypes < ActiveRecord::Migration
	def change
		create_table :patient_requests_reasons_types do |t|
			t.belongs_to :patient_request, index: true
			t.belongs_to :reasons_type, index: true
		end
	end
end