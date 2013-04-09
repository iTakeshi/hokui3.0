class CreateMlAccounts < ActiveRecord::Migration
  def change
    create_table :ml_accounts do |t|
      t.references :year, null: false, index: true
      t.string :email, null: false
      t.string :subject_prefix

      t.timestamps
    end
  end
end
