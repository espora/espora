class AddMLastNameToTherapist < ActiveRecord::Migration
  def change
    add_column :therapists, :mLastName, :string
  end
end
