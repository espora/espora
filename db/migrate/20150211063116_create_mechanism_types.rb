class CreateMechanismTypes < ActiveRecord::Migration
  def change
    create_table :mechanism_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
