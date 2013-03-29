class AddPageToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :page, :integer, null: false, default: 1
  end
end
