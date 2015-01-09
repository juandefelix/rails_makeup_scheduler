class Admin::CancellationsController < ApplicationController
  def index
  end
  
  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
    @cancellation.update_attribute(:instrument, params[:cancellation][:instrument])
    redirect_to cancellations_path, warning: "Successfully updated"
  end

  def destroy
  end
end
