class CreateAffectedAreas < ActiveRecord::Migration
  def change
    create_table :affected_areas do |t|
      t.references :patient_request, index: true
      t.references :personal_area_type, index: true
      t.string :other_name

      t.timestamps
    end
  end
end
