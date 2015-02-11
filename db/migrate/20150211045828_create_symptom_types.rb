class CreateSymptomTypes < ActiveRecord::Migration
  def change
    create_table :symptom_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
