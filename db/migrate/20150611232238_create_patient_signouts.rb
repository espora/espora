class CreatePatientSignouts < ActiveRecord::Migration
  def change
    create_table :patient_signouts do |t|
      t.references :aid_level, index: true
      t.references :condition_type, index: true
      t.integer :rating
      t.references :advise_level, index: true
      t.text :satisfactions
      t.text :claims
      t.text :observations
      t.references :patient_dropout, index: true

      t.timestamps
    end
  end
end
