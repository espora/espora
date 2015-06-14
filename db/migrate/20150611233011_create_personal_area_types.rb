class CreatePersonalAreaTypes < ActiveRecord::Migration
  def change
    create_table :personal_area_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
