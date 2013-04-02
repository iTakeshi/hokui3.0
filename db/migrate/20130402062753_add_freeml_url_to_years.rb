class AddFreemlUrlToYears < ActiveRecord::Migration
  def change
    add_column :years, :freeml_url, :string
  end
end
