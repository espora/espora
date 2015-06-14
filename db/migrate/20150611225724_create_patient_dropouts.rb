class CreatePatientDropouts < ActiveRecord::Migration
  def change
    create_table :patient_dropouts do |t|
      t.references :patient_dropout_type, index: true
      t.references :patient, index: true

      t.timestamps
    end
  end
end
