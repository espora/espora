class AddCareerToPatients < ActiveRecord::Migration
  def change
    add_reference :patients, :career, index: true
  end
end
