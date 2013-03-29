class MaterialsController < ApplicationController
  before_action :set_subject
  before_action :set_material, only: %i(edit update)

  def download
    material = Material.find(params[:id])
    material.increment(:download_count).save!
    send_file material.file_path, filename: material.display_name, type: material.file_content_type, disposition: :inline
  end

  def exams
    @exams = Material.exams
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

  private
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
