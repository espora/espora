class RemoveAdviseLevelIdFromPatientSignouts < ActiveRecord::Migration
  def change
    remove_column :patient_signouts, :advise_level_id, :integer
  end
end
