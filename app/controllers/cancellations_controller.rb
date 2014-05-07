class CancellationsController < ApplicationController

  def new
    @cancellation = Cancellation.new
  end

  def create
    @cancellation = Cancellation.new(cancellation_params)
    
    # binding.pry
    
    respond_to do |format|    
      if @cancellation.save
        flash[:success] = "Successfully created..."
        format.html { redirect_to @cancellation }
        format.js { render :json => @cancellation.id  }
      else
        # flash[:error] = "An error occurred when trying to notify an absence"
        format.html { render :new }
        format.js { render :text => "new"}
      end
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

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Cancellation.event_strips_for_month(@shown_month)
  end

  private

    def cancellation_params
      params.require(:cancellation).permit(:name, :instrument, 
                                           :date, :start_time)
    end
end
