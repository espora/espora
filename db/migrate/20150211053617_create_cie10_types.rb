class CreateCie10Types < ActiveRecord::Migration
  def change
    create_table :cie10_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
