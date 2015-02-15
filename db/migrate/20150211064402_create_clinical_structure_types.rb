class CreateClinicalStructureTypes < ActiveRecord::Migration
  def change
    create_table :clinical_structure_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
