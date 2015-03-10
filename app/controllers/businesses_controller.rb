class BusinessesController < ApplicationController

  def index
    @businesses = Business.paginate(page: params[:page])
  end

  def show
    @business = Business.find(params[:id])
    @users = @business.users.paginate(page: params[:page])
  end
end
