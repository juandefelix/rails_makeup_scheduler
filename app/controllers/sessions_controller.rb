#  require 'pry'

  class SessionsController < ApplicationController
  def new

  end

  def create
    # redirect_to root_url, :error => "This application needs you to login with Facebook"
    # binding.pry
    # PREVIOUS SESSIONS#CREATE BEFORE IMPLEMENTING THE FACEBOOK AUTHENTICATION
    # 
    # user = User.find_by(email: params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])       # if we dont have a user we can't authenticate it
    #   sign_in user
    #   redirect_to root_path 
    # else
    #   flash.now[:error] = "Invalid password/email combination"
    #   render :new
    # end
    binding.pry

    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    if user
      sign_in user
      redirect_to root_url, :notice => "Signed in!"
    else
      flash.now[:error] = "Something went wrong, try again"
      # render :new
      redirect_to root_url
    end
  end

  def failure
    flash[:error] = "This application needs you to login with Facebook"
    redirect_to root_url
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
