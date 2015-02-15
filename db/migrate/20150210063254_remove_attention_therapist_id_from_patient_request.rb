class RemoveAttentionTherapistIdFromPatientRequest < ActiveRecord::Migration
  def change
    remove_column :patient_requests, :attention_therapist_id, :integer
  end
end
