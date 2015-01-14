class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  include SessionsHelper

  def check_admin_role
    redirect_to root_url unless signed_in? && current_user.has_role?(:admin)
  end

end
