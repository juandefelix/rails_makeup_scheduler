class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order :name
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
