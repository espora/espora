class DestroySymptoms < ActiveRecord::Migration
  def change
  	drop_table :symptoms
  end
end
