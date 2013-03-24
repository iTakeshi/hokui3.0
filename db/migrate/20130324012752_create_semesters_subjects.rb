class CreateSemestersSubjects < ActiveRecord::Migration
  def change
    create_table :semesters_subjects, id: false do |t|
      t.references :semester
      t.references :subject
    end
    add_index :semesters_subjects, [:semester_id, :subject_id], unique: true
  end
end
