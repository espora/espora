class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :number
      t.datetime :date
      t.boolean :attended
      t.text :notes
      t.references :patient_record, index: true

      t.timestamps
    end
  end
end
