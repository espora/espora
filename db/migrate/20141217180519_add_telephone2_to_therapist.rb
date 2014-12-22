class AddTelephone2ToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :telephone2, :string
  end
end
