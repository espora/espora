class AddPLastNameToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :pLastName, :string
  end
end
