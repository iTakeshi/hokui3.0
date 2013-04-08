class DropFreemlEntries < ActiveRecord::Migration
  def change
    drop_table :freeml_entries
  end
end
