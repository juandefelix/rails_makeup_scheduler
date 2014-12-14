class CancellationsController < ApplicationController

  before_action :check_date_format, only: :create
  before_action :check_school_code, only: :create
  before_action :redirect_to_home_if_not_signed_in
  before_action :find_cancellation, except: [:new, :create, :index]

  def new
    @cancellation = Cancellation.new
  end


  def create
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
        flash[:danger] = "An error occurred when trying to notify an absence"
        format.html { render :new }
        format.js { render :text => "new"}
      end
    end
  end


  def show
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
    if @cancellation.creator_same_as current_user
      flash.now[:damger] = "You can not do a makeup of a lesson that you cancelled"
      render :show
    elsif current_user.exceeded_makeups?
      flash[:damger] = "Makeups will exceed number of cancellations"
      redirect_to current_user
    elsif @cancellation.in_the_past?
      flash.now[:danger] = "this date has passed. Please, select another date"
      redirect_to cancellations_path
    else
      @cancellation.update_attribute(:taker, current_user)
      redirect_to current_user, warning: "Successfully updated"
    end
  end

  def admin_update
    @cancellation.update_attribute(:instrument, params[:cancellation][:instrument])
    redirect_to cancellations_path, warning: "Successfully updated"
  end

  def destroy
    @cancellation.destroy
    flash[:success] = "Absence deleted from your list."
    redirect_to cancellations_path
  end

  private

    def find_cancellation
      @cancellation = Cancellation.find(params[:id])
    end

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
      # binding.pry
      unless valid_date?(params[:date], "%m/%d/%Y") || valid_date?(params[:date], "%m-%d-%Y")
        flash.now[:danger] = "Date format not valid"
        @cancellation = Cancellation.new
        render :new
      end
    end

    def valid_date?( str, format )
      Date.strptime(str,format) rescue false
    end

    def redirect_to_home_if_not_signed_in
      redirect_to root_url if !signed_in?
    end

    def check_school_code
      unless params[:school_code] == CONFIG[:school_code]
        redirect_to new_cancellation_path, flash: { danger: 'School Code is not correct' }
      end
    end
end