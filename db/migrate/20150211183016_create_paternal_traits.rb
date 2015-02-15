class CreatePaternalTraits < ActiveRecord::Migration
  def change
    create_table :paternal_traits do |t|
      t.boolean :from_mother
      t.references :patient_record, index: true
      t.references :paternal_trait_type, index: true

      t.timestamps
    end
  end
end
