class MaterialsController < ApplicationController
  before_action :set_subject
  before_action :set_material, only: %i(edit update destroy)
  before_action :authorize_as_admin_or_file_owner, only: %i(edit update destroy)

  def download
    material = Material.find(params[:id])
    material.increment(:download_count).save!
    send_file material.file_path, filename: material.display_name, type: material.file_content_type, disposition: :inline
  end

  def exams
    @exams = Material.exams
  end

  def quizzes
    @quizzes = Material.quizzes
  end

  def new
    @material = @subject.materials.new(material_type: params[:type])
  end

  def create
    @material = @subject.materials.new(material_params)
    @material.user = current_user
    @material.set_file_params(file_params)
    @material.set_page

    if @material.save
      @material.save_file(file_params[:file])
      redirect_to exams_study_subject_materials_path(@subject)
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    @material.comments = material_params[:comments]
    @material.file_content_type = file_params[:file].content_type
    @material.save!
    @material.save_file(file_params[:file])
    redirect_to exams_study_subject_materials_path(@subject)
  end

  def destroy
    @material.destroy_file
    @material.destroy!
    redirect_to exams_study_subject_materials_path(@subject)
  end

  private
  def authorize_as_admin_or_file_owner
    unless current_user.is_admin or current_user == @material.user
      flash[:error] = "あなたはこのファイルを編集または削除する権限がありません。"
      redirect_to exams_study_subject_materials_path(@subject)
    end
  end

  def set_subject
    @subject = Subject.find_by(title_en: params[:subject_title_en])
  end

  def set_material
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit %i(material_type class_year number with_answer comments)
  end

  def file_params
    params.require(:material).permit %i(file file_name)
  end
end
