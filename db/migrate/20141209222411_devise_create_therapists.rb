class DeviseCreateTherapists < ActiveRecord::Migration

  def change
    create_table(:therapists) do |t|

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps

      # Nombre
      t.string :name

      # Telefono
      t.string :telephone

      # Grado academico
      t.string :scholar_grade

      # Rol
      t.string :role
    end

    add_index :therapists, :email,                unique: true
    add_index :therapists, :reset_password_token, unique: true
  end
end
