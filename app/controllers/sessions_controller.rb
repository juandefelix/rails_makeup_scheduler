class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])       # if we dont have a user we can't authenticate it
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = "Invalid password/email combination"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
