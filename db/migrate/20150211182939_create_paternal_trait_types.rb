class CreatePaternalTraitTypes < ActiveRecord::Migration
  def change
    create_table :paternal_trait_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
