class DeleteAgeFromPatient < ActiveRecord::Migration
	def change
		remove_column :patients, :age
	end
end
