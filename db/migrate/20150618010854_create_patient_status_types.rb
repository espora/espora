class CreatePatientStatusTypes < ActiveRecord::Migration
  def change
    create_table :patient_status_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
