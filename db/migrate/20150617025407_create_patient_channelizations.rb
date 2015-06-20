class CreatePatientChannelizations < ActiveRecord::Migration
  def change
    create_table :patient_channelizations do |t|
      t.string :where
      t.references :patient_dropout, index: true

      t.timestamps
    end
  end
end
