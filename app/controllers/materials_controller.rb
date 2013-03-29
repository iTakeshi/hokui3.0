class MaterialsController < ApplicationController
  before_action :set_subject

  def exams
  end

  def new
    @material = @subject.materials.new(material_type: params[:type])
  end

  private
  def set_subject
    @subject = Subject.find_by(title_en: params[:subject_title_en])
  end
end
