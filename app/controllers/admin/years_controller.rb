class Admin::YearsController < ApplicationController
  def index
    @years = Year.all
  end

  def new
    @year = Year.new
  end

  def create
    @year = Year.new(year: params[:year][:class_year])

    if @year.save
      redirect_to admin_years_path
    else
      render action: :new
    end
  end
end
