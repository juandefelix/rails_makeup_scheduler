class UsersController < ApplicationController
  before_action :redirect_to_home_if_not_signed_in
  
  def show
    @user = User.find(params[:id])
    @created = @user.created_cancellations
    @taken = @user.taken_cancellations
  end
end
