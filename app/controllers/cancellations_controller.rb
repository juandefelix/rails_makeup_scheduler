require 'pry'

class CancellationsController < ApplicationController

  def new
    @cancellation = Cancellation.new
  end

  def create
    # binding.pry
    @cancellation = Cancellation.new(cancellation_params)
    
    respond_to do |format|    
      if @cancellation.save
        flash[:success] = "Successfully created..."
        format.html { redirect_to @cancellation }
        format.js { render :json => @cancellation.id  }
      else
        flash[:error] = "An error occurred when trying to notify an absence"
        render :new
      end
    end

    # if @cancellation.save
    #   flash[:success] = "Successfully created..."
    #   redirect_to @cancellation
    # else
    #   flash[:error] = "An error occurred when trying to notify an absence"
    #   render :new
    # end
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
