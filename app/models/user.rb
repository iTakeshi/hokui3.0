class User < ActiveRecord::Base
  belongs_to :year

  has_secure_password

  validates_presence_of :family_name
  validates_presence_of :given_name
  validates_presence_of :handle_name
  validates_uniqueness_of :handle_name
  validates_presence_of :birthday
  validates_presence_of :email_official
  validates_uniqueness_of :email_official
  validates_format_of :email_official, with: /\A[0-9a-zA-Z_\-]+@[a-z]+\.hokudai\.ac\.jp\Z/
  validates_presence_of :year_id

  scope :admins, -> { where(is_admin: true) }

  class << self
    def new_account(user_params)
      user = self.new(user_params)
      user.is_admin = false
      user.status = 1
      user.set_auth_token
      user.set_secret_token
      user
    end

    def generate_unique_token(token_column)
      begin
        token = SecureRandom.urlsafe_base64
      end while self.exists?(token_column.to_s => token)
      token
    end
  end

  def set_auth_token
    self.auth_token = User.generate_unique_token(:auth_token)
  end

  def set_secret_token
    self.secret_token = User.generate_unique_token(:secret_token)
    self.secret_token_generated_at = Time.now
  end

  def valid_secret_token?
    Time.now < self.secret_token_generated_at.to_datetime + 3.day
  end

  def full_name
    "#{self.family_name} #{self.given_name}"
  end

  def status_str
    case self.status
    when 0
      '通常'
    when 1
      '新規登録：メール認証待ち'
    when 2
      '新規登録：管理者承認待ち'
    end
  end
end
