class RemoveTelephoneFromTherapist < ActiveRecord::Migration
  def change
    remove_column :therapists, :telephone, :string
    remove_column :therapists, :string, :string
  end
end
