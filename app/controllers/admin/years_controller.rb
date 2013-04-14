class Admin::YearsController < Admin::ApplicationController
  before_action :set_year

  def index
    @years = Year.all
  end

  def new
    @year = Year.new
  end

  def create
    @year = Year.new(class_year: params[:year][:class_year])

    if @year.save
      redirect_to admin_years_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @year.calendar_id = params[:year][:calendar_id]
    @year.save!
    redirect_to admin_years_path, notice: 'カレンダーIDを更新しました。'
  end

  private
  def set_year
    @year = Year.find_by(class_year: params[:id])
  end
end
