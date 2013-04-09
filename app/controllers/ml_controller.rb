class MlController < ApplicationController
  def index
    @ml_archives = @current_user.year.ml_account.ml_archives.order('sent_at DESC').page(params[:page])
  end

  def download
    archive = MlArchive.find(params[:id])
    render json: { subject: archive.subject, body: archive.body_to_html }
  end
end
