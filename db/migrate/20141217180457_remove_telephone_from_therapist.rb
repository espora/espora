class RemoveTelephoneFromTherapist < ActiveRecord::Migration
  def change
    remove_column :therapists, :telephone, :string
  end
end
