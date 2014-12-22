class CreateRequestSchedules < ActiveRecord::Migration
  def change
    create_table :request_schedules do |t|
      t.integer :day
      t.time :beginH
      t.time :endH
      t.references :patient_request, index: true

      t.timestamps
    end
  end
end
