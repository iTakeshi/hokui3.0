class Admin::SemestersController < Admin::ApplicationController
  before_action :set_year
  before_action :set_semester, only: :edit

  def index
    @year_semesters = @year.semesters.includes(:subjects)
  end

  def new
    @year_semester = @year.semesters.new

    identifiers = (1..6).map { |num| ["#{num}a", "#{num}b"] }.flatten #=> ["1a", "1b", "2a", ..., "6b"]
    @identifier_options = identifiers.map { |i| ["#{i[0]}年#{i[1] == 'a' ? '前期' : '後期'}", i] }
  end

  def create
    @year_semester = @year.semesters.new(identifier: params[:semester][:identifier])

    if @year_semester.save
      redirect_to edit_admin_year_semester_path(@year, @year_semester)
    else
      flash[:error] = "#{@year.class_year}期の#{@year.identifier_to_str}はすでに登録されています。"
      redirect_to admin_year_semesters_path(@year)
    end
  end

  def edit
  end

  private
  def set_year
    @year = Year.where(class_year: params[:year_id]).first
  end

  def set_semester
    @semester = @year.semesters.where(identifier: params[:id]).first
  end
end
