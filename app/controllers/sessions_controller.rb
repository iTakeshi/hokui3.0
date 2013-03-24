class SessionsController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :update_last_login_timestamp

  def new
  end

  def create
    user = User.where(email_official: params[:email_official]).first

    if user && user.authenticate(params[:password])
      session[:auth_token] = user.auth_token
      redirect_to root_path
    else
      flash[:error] = "ELMSメール、またはパスワードが間違っています。もう一度お試しください。初めての方は新規登録をおねがいします。"
      render action: :new
    end
  end
end
