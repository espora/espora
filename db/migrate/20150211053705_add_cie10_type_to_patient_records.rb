class AddCie10TypeToPatientRecords < ActiveRecord::Migration
  def change
    add_reference :patient_records, :cie10_type, index: true
  end
end
