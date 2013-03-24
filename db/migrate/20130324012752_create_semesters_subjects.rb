class CreateSemestersSubjects < ActiveRecord::Migration
  def change
    create_table :semesters_subjects do |t|
      t.references :semester, null: false, index: true
      t.references :subject,  null: false, index: true
    end
  end
end
