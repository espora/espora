class FixAffectedArea < ActiveRecord::Migration
	def change
		remove_column :affected_areas, :area
		add_column :affected_areas, :other_name, :string
	end
end
