class RemoveFreemlAccountFromYears < ActiveRecord::Migration
  def change
    remove_column :years, :freeml_account
  end
end
