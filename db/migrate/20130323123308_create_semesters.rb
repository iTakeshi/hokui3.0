class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.references :year,   null: false, index: true
      t.string :identifier, null: false

      t.timestamps
    end
  end
end
