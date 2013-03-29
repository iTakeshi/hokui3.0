class StudyController < ApplicationController
  def index
    @semesters = current_user.year.semesters.includes(:subjects)
  end
end
