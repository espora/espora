class CreateAffectedAreas < ActiveRecord::Migration
  def change
    create_table :affected_areas do |t|
      t.string :area
      t.references :patient_request, index: true

      t.timestamps
    end
  end
end
