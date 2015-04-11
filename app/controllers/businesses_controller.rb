class BusinessesController < ApplicationController
  
  def new
    @business = Business.new
  end

  def index
    @businesses = Business.paginate(page: params[:page])
  end

  def show
    redirect_to root_path unless signed_in?
    @business = Business.find(params[:id])
    @users = @business.users.paginate(page: params[:page])
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      flash[:success] = "Business created successfully!"
      redirect_to @business
    else
      render 'new'
    end
  end

  private

    def business_params
      params.require(:business).permit(:name, :email, :city, :zip, :phone_number, :website)
    end
end
