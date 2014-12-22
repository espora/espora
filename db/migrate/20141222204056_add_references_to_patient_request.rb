class AddReferencesToPatientRequest < ActiveRecord::Migration
  def change
  	add_column :patient_requests, :receive_therapist_id, :integer
  	add_column :patient_requests, :attention_therapist_id, :integer
  end
end
