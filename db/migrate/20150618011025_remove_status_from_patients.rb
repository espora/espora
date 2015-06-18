class RemoveStatusFromPatients < ActiveRecord::Migration
	def change
		remove_column :patients, :status
	end
end
