class AddTelephone1ToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :telephone1, :string
  end
end
