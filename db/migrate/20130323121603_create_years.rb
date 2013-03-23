class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.integer :class_year, null: false

      t.timestamps
    end
    add_index :years, :class_year, unique: true
  end
end
