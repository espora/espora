class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :p_last_name
      t.string :m_last_name
      t.string :names
      t.integer :account_number
      t.date :birth
      t.integer :age
      t.string :sex
      t.string :career
      t.string :init_school
      t.integer :semester
      t.integer :failed_subjects
      t.string :telephone1
      t.string :telephone2
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
