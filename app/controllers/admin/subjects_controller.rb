class Admin::SubjectsController < ApplicationController
  before_action :set_subject, only: %i(edit update)

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to admin_subjects_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @subject.staff_name = params[:staff_name]
    if @subject.save
      redirect_to admin_subjects_path
    else
      render action: :edit
    end
  end

  private
  def subject_params
    params.require(:subject).permit %i(title_en title_ja staff_name)
  end

  def set_subject
    @subject = Subject.where(id: params[:id]).first
  end
end
