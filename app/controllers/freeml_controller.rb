class FreemlController < ApplicationController
  def index
    @entries = current_user.year.freeml_entries.order('freeml_id DESC').page(params[:page])
  end

  def download
    entry = Year.find_by(class_year: params[:class_year]).freeml_entries.find_by(freeml_id: params[:freeml_id])
    render json: { title: entry.title, body: entry.body_to_html }
  end
end
