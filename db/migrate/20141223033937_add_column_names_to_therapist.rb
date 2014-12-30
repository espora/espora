class AddColumnNamesToTherapist < ActiveRecord::Migration
  def change
  	add_column :therapists, :p_last_name, :string
  	add_column :therapists, :m_last_name, :string
  	add_column :therapists, :names, :string
  end
end
