class ApplicationController < ActionController::API
  # include SessionsHelper

  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to v0_root_path
  end
end
