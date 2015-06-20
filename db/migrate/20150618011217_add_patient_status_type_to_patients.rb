class AddPatientStatusTypeToPatients < ActiveRecord::Migration
  def change
    add_reference :patients, :patient_status_type, index: true
  end
end
