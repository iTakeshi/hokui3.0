class StudyController < ApplicationController
  def index
    @semesters = current_user.year.semesters.includes(:subjects)
  end

  def subject
    @subject = Subject.find_by(title_en: params[:subject_title_en])
  end
end
