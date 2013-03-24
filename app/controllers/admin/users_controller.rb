class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.all
  end

  def show
  end

  def approve
    unless @user.status == 2
      flash[:error] = "不正な操作：このユーザーは管理者承認待ち状態ではありません。"
      redirect_to admin_user_path(@user)
      return
    end

    @user.status = 0
    @user.save!
    Notifier.approval_notification(@user).deliver
    redirect_to admin_user_path(@user)
  end

  def reject
    unless @user.status == 2
      flash[:error] = "不正な操作：このユーザーは管理者承認待ち状態ではありません。"
      redirect_to admin_user_path(@user)
      return
    end

    Notifier.rejection_notification(@user).deliver
    flash[:warning] = "ユーザーの新規登録を拒否しました。忘れずに、拒否理由を記したメールを#{@user.email_official}に送信してください。"
    redirect_to admin_user_path(@user)
  end

  def promote
    @user.is_admin = true
    @user.save!
    Notifier.promotion_notification(@user).deliver
    redirect_to admin_user_path(@user)
  end

  def demote
    @user.is_admin = false
    @user.save!
    Notifier.demotion_notification(@user).deliver
    redirect_to admin_user_path(@user)
  end

  private
  def set_user
    @user = User.where(id: params[:id]).first
  end
end
