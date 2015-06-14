class CreateImproveAreas < ActiveRecord::Migration
  def change
    create_table :improve_areas do |t|
      t.references :patient_signout, index: true
      t.references :personal_area_type, index: true
      t.string :other_name

      t.timestamps
    end
  end
end
