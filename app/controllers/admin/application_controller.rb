class Admin::ApplicationController < ApplicationController
  before_action :authenticate_as_admin

  def authenticate_as_admin
    redirect_to root_path unless current_user.is_admin
  end
end
