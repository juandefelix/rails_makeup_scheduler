module Admin::CancellationsHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  def admin_event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >",
      :link_to_day_action => "day"
    }
  end

  def admin_event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar admin_event_calendar_opts do |args|
      event = args[:event]
      %(<a href="#{edit_admin_cancellation_path(event.id)}" title="#{h(event.instrument)}">#{h(event.instrument)} #{h(event.get_time)} #{"RESERV" unless event.available?}</a>) 
    end
  end

  def formatted_time
    year = params[:year].to_i
    month = params[:month].to_i
    day = params[:day].to_i
    "#{month}/#{day}/#{year}"
  end

  def taker_of(cancellation)
    return '' unless cancellation.taker
    cancellation.taker.name
  end
end
