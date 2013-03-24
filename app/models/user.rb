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
  validates_format_of :email_official, with: /\A[0-9a-zA-Z_]+@[a-z]+\.hokudai\.ac\.jp\Z/
end
