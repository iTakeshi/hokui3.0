class CreateMlArchives < ActiveRecord::Migration
  def change
    create_table :ml_archives do |t|
      t.references :ml_account, index: true, null: false
      t.string :from, null: false
      t.string :from_name
      t.datetime :sent_at, null: false
      t.string :subject, null: false
      t.integer :archive_number
      t.text :body, null: false

      t.timestamps
    end
  end
end
