class CreateAffectedAreaTypes < ActiveRecord::Migration
  def change
    create_table :affected_area_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
