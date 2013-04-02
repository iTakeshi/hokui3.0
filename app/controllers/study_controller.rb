class StudyController < ApplicationController
  def index
  end

  def subject
    @subject = Subject.find_by(title_en: params[:subject_title_en])
  end
end
