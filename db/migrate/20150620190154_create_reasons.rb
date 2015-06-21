class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :other_name
      t.references :patient_request, index: true
      t.references :reasons_type, index: true

      t.timestamps
    end
  end
end
