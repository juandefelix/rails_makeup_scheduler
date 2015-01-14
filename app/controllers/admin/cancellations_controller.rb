class Admin::CancellationsController < ApplicationController
  before_action :check_admin_role
  def index
    @cancellations = Cancellation.all

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Cancellation.event_strips_for_month(@shown_month)

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
  end

  def create
  end

  def edit
    @cancellation = Cancellation.find params[:id]
  end

  def update
    @cancellation.update_attribute(:instrument, params[:cancellation][:instrument])
    redirect_to cancellations_path, warning: "Successfully updated"
  end

  def destroy
  end
end
