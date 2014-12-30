class AddPatientToPatientRequest < ActiveRecord::Migration
  def change
    add_reference :patient_requests, :patient, index: true
  end
end
