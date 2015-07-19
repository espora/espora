class AddAdviseLevelTypeToPatientSignout < ActiveRecord::Migration
  def change
    add_reference :patient_signouts, :advise_level_type, index: true
  end
end
