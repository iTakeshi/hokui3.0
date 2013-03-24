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

  def approval_notification(user)
    @user = user
    mail to: user.email_official, subject: '北医ネット：登録承認のお知らせ'
  end

  def rejection_notification(user)
    @user = user
    mail to: user.email_official, subject: '北医ネット：登録拒否のお知らせ'
  end

  def promotion_notification(user)
    @user = user
    mail to: user.email_official, subject: '北医ネット：管理者へ昇格しました'
  end

  def demotion_notification(user)
    @user = user
    mail to: user.email_official, subject: '北医ネット：一般ユーザーへ降格しました'
  end
end
