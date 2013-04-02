class Admin::YearsController < Admin::ApplicationController
  before_action :set_year, only: %i(edit update)

  def index
    @years = Year.all
  end

  def new
    @year = Year.new
  end

  def create
    @year = Year.new(class_year: params[:year][:class_year])

    if @year.save
      redirect_to edit_admin_year_path(@year)
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @year.freeml_account = params[:year][:freeml_account]
    if FreemlEntry.check_account(@year)
      @year.save!
      redirect_to admin_years_path, notice: '設定しました。'
    else
      redirect_to edit_admin_year_path(@year), alert: '指定されたFreeml accountにアクセスできません。ページが存在しないか、またはhokui.net@gmail.comがMLに参加していません。'
    end
  end

  private
  def set_year
    @year = Year.where(class_year: params[:id]).first
  end
end
