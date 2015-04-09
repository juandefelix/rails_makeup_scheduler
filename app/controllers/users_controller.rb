class UsersController < ApplicationController
  load_and_authorize_resource
  
  before_action :redirect_to_home_if_not_signed_in

  def show
    @user = User.find(params[:id])
    if current_user.has_role?(:admin) || current_user == @user
      @created = @user.created_cancellations
      @taken = @user.taken_cancellations
    else
      flash[:danger] = "You can not access this page"
      redirect_to root_path
    end
  end
end
