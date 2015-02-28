class SessionsController < ApplicationController
  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if user
      sign_in user
      redirect_to root_url, :warning => "Signed in!"
    else
      flash.now[:danger] = "Something went wrong, try again"
      redirect_to root_url
    end
  end

  def failure
    flash[:danger] = "This application needs you to login with Facebook"
    redirect_to root_url
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
