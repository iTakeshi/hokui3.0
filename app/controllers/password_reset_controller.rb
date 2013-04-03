class PasswordResetController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :update_last_login_timestamp

  def new
  end

  def create
    @user = User.find_by(email_official: params[:email_official])
    if @user
      @user.status = 3
      @user.set_secret_token
      @user.save!
      Notifier.password_reset(@user).deliver
    else
      flash.now[:alert] = 'ELMSメールアドレスが間違っています。'
      render action: :new
    end
  end

  def set_password
    @user = User.find_by(secret_token: params[:secret_token])
    unless @user && @user.valid_secret_token?
      redirect_to login_path, alert: 'パスワード再設定用URLが間違っているか、または有効期限が切れています。'
    end
    unless @user.status == 3
      redirect_to login_path, alert: 'パスワード再設定の手続き中ではありません。'
    end
  end

  def update_password
    @user = User.find_by(secret_token: params[:secret_token])
    unless @user && @user.valid_secret_token?
      redirect_to login_path, alert: 'パスワード再設定用URLが間違っているか、または有効期限が切れています。'
    end
    unless @user.status == 3
      redirect_to login_path, alert: 'パスワード再設定の手続き中ではありません。'
    end

    if params[:password] == params[:password_confirmation]
      @user.password = params[:password]
      @user.status = 0
      @user.save!
      redirect_to login_path, notice: 'パスワードを再設定しました。'
    else
      flash.now[:alert] = 'パスワードの確認が一致しません。'
      render action: :set_password
    end
  end
end
