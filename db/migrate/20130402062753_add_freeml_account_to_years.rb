class AddFreemlAccountToYears < ActiveRecord::Migration
  def change
    add_column :years, :freeml_account, :string
  end
end
