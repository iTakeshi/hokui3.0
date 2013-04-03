class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate
  before_action :update_last_login_timestamp

  helper_method :current_user

  private
  def authenticate
    if current_user
      @current_user = current_user
      if cookies[:remember_me] == "1"
        request.session_options[:expire_after] = 60 * 60 * 24 * 14
      end
    else
      redirect_to login_path
    end
  end

  def current_user
    user = User.find_by(auth_token: session[:auth_token])
    if user
      if user.status == 0
        user
      else
        flash[:error] = case user.status
          when 1
            'メールアドレスの確認が完了していません。ELMSメールの受信ボックスを確認してください。'
          when 2
            '管理者の承認が完了していません。承認されると、ELMSメールに通知されます。しばらくお待ちください。'
          else
            nil
          end
        nil
      end
    else
      nil
    end
  end

  def update_last_login_timestamp
    @current_user.last_login_at = Time.now
    @current_user.save!
  end
end
