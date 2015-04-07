class SessionsController < ApplicationController
  def failure
    flash[:danger] = "This application needs you to login with Facebook"
    redirect_to root_url
  end
end
