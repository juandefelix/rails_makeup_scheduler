class CancellationsController < ApplicationController

  def new
    @cancellation = Cancellation.new
  end

  def create
    @cancellation = Cancellation.new(cancellation_params)
    
    if @cancellation.save
      flash[:success] = "Successfully created..."
      @cancellation.id
      redirect_to @cancellation
    else
      flash[:error] = "An error occurred when trying to notify an absence"
      render :new
    end
  end
  
  def destroy
    Cancellation.find(params[:id]).destroy
    flash[:success] = "Absence deleted from your list."
    redirect_to cancellations_url
  end

  def show
    @cancellation = Cancellation.find(params[:id])
  end

  def index
    @cancellations = Cancellation.all
  end

  private

    def cancellation_params
      params.require(:cancellation).permit(:name, :instrument, 
                                           :date, :start_time)
    end
end
