class CreateSymptoms < ActiveRecord::Migration
  def change
    create_table :symptoms do |t|
      t.references :symptom_type, index: true
      t.integer :level
      t.references :appointment, index: true

      t.timestamps
    end
  end
end
