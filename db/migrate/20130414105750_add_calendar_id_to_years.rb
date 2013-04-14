class AddCalendarIdToYears < ActiveRecord::Migration
  def change
    add_column :years, :calendar_id, :string
  end
end
