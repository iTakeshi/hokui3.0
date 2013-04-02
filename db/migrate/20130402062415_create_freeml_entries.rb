class CreateFreemlEntries < ActiveRecord::Migration
  def change
    create_table :freeml_entries do |t|
      t.references :year, index: true
      t.integer :freeml_id
      t.string :sender_name
      t.string :title
      t.text :body
      t.datetime :sent_at

      t.timestamps
    end
  end
end
