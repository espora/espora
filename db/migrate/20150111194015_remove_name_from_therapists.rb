class RemoveNameFromTherapists < ActiveRecord::Migration
  def change
    remove_column :therapists, :name, :string
  end
end
