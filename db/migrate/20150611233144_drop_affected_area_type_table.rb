class DropAffectedAreaTypeTable < ActiveRecord::Migration
  def change
  	drop_table :affected_area_types
  end
end
