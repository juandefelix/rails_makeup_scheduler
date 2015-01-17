class Admin::CancellationsController < ApplicationController
  before_action :check_admin_role
  before_action :find_cancellation, only: [:edit, :update, :destroy]
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Cancellation.reorder(:start_at).event_strips_for_month(@shown_month)

    # To restrict what events are included in the result you can pass additional find options like this:
    #
    # @event_strips = Event.event_strips_for_month(@shown_month, :include => :some_relation, :conditions => 'some_relations.some_column = true')
    #
  end

  def day
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    @cancellations = Cancellation.by_day(year, month, day).reorder(:start_at)
  end
  
  def show
  end

  def new
    @cancellation = Cancellation.new
  end

  def create
    user_name = User.find(params[:user_id]).name
    @cancellation = Cancellation.new(name: user_name,
                                     instrument: params[:cancellation][:instrument],
                                     start_at: get_date_time, 
                                     end_at: (get_date_time + 30.minutes),
                                     creator_id: params[:user_id])

    if @cancellation.save
      flash[:success] = "Succesfully notified..."
      redirect_to admin_cancellations_path
    else
      flash[:danger] = "An error occurred when trying to notify an absence"
      render :new
    end
  end

  def edit
  end

  def update
    @cancellation.update_attribute(:instrument, params[:cancellation][:instrument])
    flash[:success] = "Successfully updated"
    redirect_to admin_cancellations_path
  end

  def destroy
    @cancellation.destroy
    flash[:success] = "Absence deleted from your list."
    redirect_to admin_cancellations_path
  end
end
