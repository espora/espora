class CreatePatientRecords < ActiveRecord::Migration
  def change
    create_table :patient_records do |t|
      t.text :observations
      t.text :lives_with
      t.references :patient, index: true
      t.references :therapist, index: true

      t.timestamps
    end
  end
end
