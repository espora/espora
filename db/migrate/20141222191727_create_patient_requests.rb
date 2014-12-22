class CreatePatientRequests < ActiveRecord::Migration
  def change
    create_table :patient_requests do |t|
      t.text :reasons
      t.string :condition
      t.string :how_met
      t.float :money
      t.boolean :pre_care
      t.date :request_date
      t.date :attention_date

      t.timestamps
    end
  end
end
