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

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
