class CreateHowMets < ActiveRecord::Migration
  def change
    create_table :how_mets do |t|
      t.references :patient_request, index: true
      t.references :how_met_type, index: true
      t.string :other_name

      t.timestamps
    end
  end
end
