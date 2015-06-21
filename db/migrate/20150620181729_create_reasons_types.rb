class CreateReasonsTypes < ActiveRecord::Migration
  def change
    create_table :reasons_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
