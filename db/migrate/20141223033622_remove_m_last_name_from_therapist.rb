class RemoveMLastNameFromTherapist < ActiveRecord::Migration
  def change
    remove_column :therapists, :mLastName, :string
  end
end
