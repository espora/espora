class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      t.references :branch, index: true

      t.timestamps
    end
  end
end