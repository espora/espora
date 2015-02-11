class AddContactTherapistIdToPatientRequest < ActiveRecord::Migration
  def change
    add_column :patient_requests, :contact_therapist_id, :integer
  end
end
