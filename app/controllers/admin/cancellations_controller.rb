class Admin::CancellationsController < ApplicationController
  before_action :check_admin_role
  before_action :admin_check_school_code, only: :create
  before_action :find_cancellation, only: [:edit, :update, :destroy]

  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Cancellation.event_strips_for_month(@shown_month)

    # To restrict what events are included in the result you can pass additional find options like this:
    #
    # @event_strips = Event.event_strips_for_month(@shown_month, :include => :some_relation, :conditions => 'some_relations.some_column = true')
    #

    respond_to do |format|
      format.html
      format.js { render :index }
    end
  end

  def day
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    
    @cancellations = Cancellation.by_day(year, month, day)
  end
  
  def show
  end

  def new
    @cancellation = Cancellation.new
  end

  def create
    user_name = User.find(params[:user_id]).name
    @cancellation = Cancellation.new(name: user_name,
                                     instrument: params[:cancellation][:instrument].capitalize,
                                     start_at: get_date_time, 
                                     end_at: (get_date_time + 30.minutes),
                                     creator_id: params[:user_id])

    if @cancellation.save
      flash[:success] = "Succesfully notified..."
      redirect_to admin_cancellations_path
    else
      flash[:danger] = "An error occurred when trying to notify an absence."
      render :new
    end
  end

  def edit
    flash.now[:warning] = "Cancellation already taken!! Make sure yo want to modify or delete it." if @cancellation.taker
  end

  def update
    if params[:cancellation] && params && params[:cancellation][:instrument].present? 
      @cancellation.update_attribute(:instrument, params[:cancellation][:instrument])
      flash[:success] = "Successfully updated"
      if params[:cancellation][:instrument].blank?
        redirect_to edit_admin_cancellation_path @cancellation, flash[:danger] = "Instrument can't be empty"
      else
        redirect_to admin_cancellations_path
      end
    else
      user = @cancellation.taker
      # binding.pry
      # user.delete_taken_cancellations @cancellation
      user.taken_cancellations.delete @cancellation
      flash[:success] = "Makeup available"
      redirect_to edit_admin_cancellation_path @cancellation
    end
  end

  def destroy
    user = @cancellation.creator
    user.created_cancellations.destroy @cancellation
    flash[:success] = "Absence deleted from your list."
    redirect_to admin_cancellations_path
  end

  private


  def admin_check_school_code
    unless params[:school_code] == ENV['SCHOOL_CODE']
      redirect_to new_admin_cancellation_path, flash: { danger: 'School Code is not correct' }
    end
  end
end
