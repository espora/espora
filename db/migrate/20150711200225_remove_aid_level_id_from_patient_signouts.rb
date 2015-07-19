class RemoveAidLevelIdFromPatientSignouts < ActiveRecord::Migration
  def change
    remove_column :patient_signouts, :aid_level_id, :integer
  end
end
