class ReFixStatusFromPatient < ActiveRecord::Migration
  def change
  	remove_column :patients, :status
  	add_column :patients, :status, :string
  end
end
