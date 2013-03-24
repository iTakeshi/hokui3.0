class SignupController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new_account(user_params)

    if @user.save
      Notifier.signup_confirmation(@user).deliver
    else
      render action: :new
    end
  end

  def confirm
    @user = User.where(secret_token: params[:secret_token]).first

    if @user && @user.valid_secret_token?
      @user.status = 2
      @user.save!
      User.admins.each do |admin|
        Notifier.request_for_approval(admin, @user).deliver
      end
    else
      flash[:error] = "認証URLが間違っているか、または認証URLの有効期限を過ぎています。もう一度登録画面からやり直してください。"
      redirect_to signup_path
    end
  end

  private
  def user_params
    params.require(:user).permit %i(family_name given_name handle_name birthday year_id email_official email_private password password_confirmation)
  end
end
