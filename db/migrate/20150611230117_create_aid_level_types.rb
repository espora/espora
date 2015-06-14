class CreateAidLevelTypes < ActiveRecord::Migration
  def change
    create_table :aid_level_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
