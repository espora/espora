class CreateHowMetTypes < ActiveRecord::Migration
  def change
    create_table :how_met_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
