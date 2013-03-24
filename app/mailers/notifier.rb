class Notifier < ActionMailer::Base
  default from: 'hokui.net@gmail.com'

  def signup_confirmation(user)
    @user = user
    mail to: user.email_official, subject: '北医ネットへようこそ'
  end

  def request_for_approval(admin, user)
    @user = user
    mail to: admin.email_official, subject: '北医ネット：ユーザー承認リクエスト'
  end
end
