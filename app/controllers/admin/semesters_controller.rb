class Admin::SemestersController < Admin::ApplicationController
  def index
    @year = Year.where(class_year: params[:year_id]).first
    @year_semesters = @year.semesters.includes(:subjects)
  end
end
