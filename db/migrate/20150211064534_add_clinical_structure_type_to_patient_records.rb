class AddClinicalStructureTypeToPatientRecords < ActiveRecord::Migration
  def change
    add_reference :patient_records, :clinical_structure_type, index: true
  end
end
