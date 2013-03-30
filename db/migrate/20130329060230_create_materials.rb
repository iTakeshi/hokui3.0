class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.references :subject, null: false, index: true
      t.references :user,    null: false, index: true
      t.integer :class_year
      t.integer :number
      t.boolean :with_answer
      t.string :comments
      t.string :file_name,         null: false
      t.string :file_content_type, null: false
      t.integer :download_count,   null: false, default: 0

      t.timestamps
    end
    add_index :materials, :file_name, unique: true
  end
end
