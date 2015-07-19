class AddAidLevelTypeToPatientSignout < ActiveRecord::Migration
  def change
    add_reference :patient_signouts, :aid_level_type, index: true
  end
end
