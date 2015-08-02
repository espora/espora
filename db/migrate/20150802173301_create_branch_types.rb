class CreateBranchTypes < ActiveRecord::Migration
  def change
    create_table :branch_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
