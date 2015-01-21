class Admin::UsersController < ApplicationController
  before_action :check_admin_role
  
  def index
    @users = User.all.order :name
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
