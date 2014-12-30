class RemovePLastNameFromTherapist < ActiveRecord::Migration
  def change
    remove_column :therapists, :pLastName, :string
  end
end
