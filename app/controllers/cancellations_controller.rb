class CancellationsController < ApplicationController

  def new
    @cancellation = Cancellation.new
  end

  def create
    @cancellation = Cancellation.new(cancellation_params)
    if @cancellation.save
      flash[:success] = "Successfully created..."
      redirect_to @cancellation
    else
      flash[:error] = "An error occurred when trying to create an absence"
      render 'new'
    end
  end
  
  def destroy
  end

  def show
    @cancellation = Cancellation.find(params[:id])
  end

  def index
    @cancellation = Cancellation.all
  end

  private

    def cancellation_params
      params.require(:cancellation).permit(:name, :instrument, 
                                           :date, :start_time, :end_time)
    end
end
