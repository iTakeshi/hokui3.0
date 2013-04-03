class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.attributes = profile_params

    if @user.save
      redirect_to edit_profile_path, notice: '更新に成功しました。'
    else
      render action: :edit
    end
  end

  def password
  end

  def update_password
    if @current_user.authenticate(params[:current_password])
      if params[:password] == params[:password_confirmation]
        @current_user.password = params[:password]
        @current_user.save!
        redirect_to edit_profile_path, notice: 'パスワードを更新しました。'
      else
        redirect_to password_profile_path, alert: 'パスワードの確認が一致しません。'
      end
    else
      redirect_to password_profile_path, alert: '現在のパスワードが違います。'
    end
  end

  private
  def profile_params
    params.require(:user).permit %i(handle_name year_id email_private)
  end
end
