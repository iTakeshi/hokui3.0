class MlController < ApplicationController
  def index
    if @current_user.year.ml_account
      @ml_archives = @current_user.year.ml_account.ml_archives.order('sent_at DESC').page(params[:page])
    else
      flash[:alert] = "#{@current_user.year.class_year}期のメーリングリストが登録されていません。管理者へご連絡ください。"
      @ml_archives = []
    end
  end

  def download
    archive = MlArchive.find(params[:id])
    render json: { subject: archive.subject, body: archive.body_to_html }
  end
end
