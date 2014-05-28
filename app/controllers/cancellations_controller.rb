require 'pry'

class CancellationsController < ApplicationController

before_action :check_date_format, only: :create
before_action :redirect_to_home_if_not_signed_in
  def new
    @cancellation = Cancellation.new
  end

  def create
    # binding.pry

    @cancellation = Cancellation.new(name: params[:cancellation][:name],
                                     instrument: params[:cancellation][:instrument],
                                     start_at: get_date_time, 
                                     end_at: (get_date_time + 30.minutes),
                                     creator_id: current_user.id)

    respond_to do |format|    
      if @cancellation.save
        flash[:success] = "Successfully notified..."
        format.html { redirect_to @cancellation }
        format.js { render :json => @cancellation.id  }
      else
        flash[:error] = "An error occurred when trying to notify an absence"
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

  def edit
    @cancellation = Cancellation.find(params[:id])
  end

  def update
    @cancellation = Cancellation.find(params[:id])
    # binding.pry
    @cancellation.update_attributes(taker: current_user)
    redirect_to cancellations_path
  end

  private

  def cancellation_params
      params.require(:cancellation).permit(:name, :instrument, :start_at)
  end

  def get_date_time
    date_and_time = params[:date] + " " + params[:cancellation][:start_at]
    date_and_time_array = date_and_time.split(/[\D]/)

    year = date_and_time_array[2].blank? ? "2000" : ("20" + date_and_time_array[2])
    month = date_and_time_array[0].blank? ? "01" : date_and_time_array[0]
    day = date_and_time_array[1].blank? ? "01" : date_and_time_array[1]
    hour = date_and_time_array[3]  || "12"
    minute = date_and_time_array[4]  || "00"

    Time.local(year, month, day, hour, minute)
  end

  def check_date_format
    unless params[:date] =~ /\A[01]?\d[\/-][0-3]?\d[\/-]\d{2}?\d{2}\z/
      flash.now[:error] = "Date format not valid"
      @cancellation = Cancellation.new
      render :new
    end
  end

  def redirect_to_home_if_not_signed_in
    redirect_to root_url if !signed_in?
  end
end
