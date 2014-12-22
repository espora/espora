class CreateTherapistSchedules < ActiveRecord::Migration
  def change
    create_table :therapist_schedules do |t|
      t.integer :day
      t.time :beginH
      t.time :endH
      t.references :therapist, index: true

      t.timestamps
    end
  end
end
