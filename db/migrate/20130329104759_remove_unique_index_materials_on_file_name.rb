class RemoveUniqueIndexMaterialsOnFileName < ActiveRecord::Migration
  def change
    remove_index :materials, :file_name
  end
end
