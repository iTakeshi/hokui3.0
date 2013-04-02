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

  private
  def profile_params
    params.require(:user).permit %i(handle_name year_id email_private)
  end
end
