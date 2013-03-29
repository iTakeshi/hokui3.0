class MaterialsController < ApplicationController
  before_action :set_subject

  def download
    material = Material.find(params[:id])
    send_file material.file_path, filename: material.file_name, type: material.file_content_type, disposition: :inline
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

  private
  def set_subject
    @subject = Subject.find_by(title_en: params[:subject_title_en])
  end

  def material_params
    params.require(:material).permit %i(material_type class_year number with_answer comments)
  end

  def file_params
    params.require(:material).permit %i(file file_name)
  end
end
