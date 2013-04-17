class AddStrippedSubjectToMlArchives < ActiveRecord::Migration
  def change
    add_column :ml_archives, :stripped_subject, :string
  end
end
