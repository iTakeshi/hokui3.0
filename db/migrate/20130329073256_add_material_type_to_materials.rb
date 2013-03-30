class AddMaterialTypeToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :material_type, :string, null: false, default: :exam, index: true
  end
end
