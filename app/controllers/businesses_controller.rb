class BusinessesController < ApplicationController

  def index
    @businesses = Business.paginate(page: params[:page])
  end

  def new
  end

  def create
  end

  def show
  end
end
