class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show

    redirect_to root_path unless signed_in?
    @user = User.find(params[:id])
    @created = @user.created_cancellations
    @taken = @user.taken_cancellations
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Makeup Scheduler!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
