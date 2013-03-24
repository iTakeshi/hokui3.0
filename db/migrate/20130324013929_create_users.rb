class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :family_name,     null: false
      t.string     :given_name,      null: false
      t.string     :handle_name,     null: false
      t.date       :birthday,        null: false
      t.string     :email_official,  null: false
      t.string     :email_private
      t.references :year,            null: false
      t.boolean    :is_admin,        null: false, default: false
      t.integer    :status,          null: false
      t.string     :auth_token,      null: false
      t.string     :secret_token
      t.string     :secret_token_generated_at
      t.string     :password_digest, null: false
      t.datetime   :last_login_at

      t.timestamps
    end
    add_index :users, :handle_name, unique: true
    add_index :users, :email_official, unique: true
    add_index :users, :auth_token, unique: true
  end
end
