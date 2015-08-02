class FixRoleAndCareer < ActiveRecord::Migration
	def change
		remove_column :therapists, :role
		remove_column :patients, :career
	end
end
