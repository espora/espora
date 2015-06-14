class CreateConditionTypes < ActiveRecord::Migration
  def change
    create_table :condition_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
