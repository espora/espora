class CreateAdviseLevelTypes < ActiveRecord::Migration
  def change
    create_table :advise_level_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
