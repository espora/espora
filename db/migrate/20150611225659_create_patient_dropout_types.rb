class CreatePatientDropoutTypes < ActiveRecord::Migration
  def change
    create_table :patient_dropout_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
