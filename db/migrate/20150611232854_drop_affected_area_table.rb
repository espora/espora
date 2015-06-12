class DropAffectedAreaTable < ActiveRecord::Migration
	def change
		drop_table :affected_areas
	end
end
