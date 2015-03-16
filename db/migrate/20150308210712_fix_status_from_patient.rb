class FixStatusFromPatient < ActiveRecord::Migration
  def change
  	remove_column :patients, :status
  	add_column :patients, :status, :integer
  end
end
