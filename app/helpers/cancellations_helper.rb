module CancellationsHelper
  # ------------------------------#
  # new cancellation form helpers #
  # ----------------------------- #

  def times
    [ ["9:00 am", "09:00"], 
    ["9:30 am", "09:30"], 
    ["10:00 am", "10:00"], 
    ["10:30 am", "10:30"], 
    ["11:00 am", "11:00"], 
    ["11:30 am", "11:30"], 
    ["12:00 pm", "12:00"], 
    ["12:30 pm", "12:30"], 
    ["1:00 pm", "13:00"], 
    ["1:30 pm", "13:30"], 
    ["2:00 pm", "14:00"], 
    ["2:30 pm", "14:30"], 
    ["3:00 pm", "15:00"], 
    ["3:30 pm", "15:30"], 
    ["4:00 pm", "16:00"], 
    ["4:30 pm", "16:30"], 
    ["5:00 pm", "17:00"], 
    ["5:30 pm", "17:30"], 
    ["6:00 pm", "18:00"], 
    ["6:30 pm", "18:30"], 
    ["7:00 pm", "19:00"], 
    ["7:30 pm", "19:30"], 
    ["8:00 pm", "20:00"], 
    ["8:30 pm", "20:30"] ]
  end

  def last_name_used
    # 'name' takes the earliest cancellation in the latest day. 
    # We want the latest cancellatio in the lastest dat
    name = current_user.created_cancellations.last.try(:name)
    new_cancellation_field(:name) || name || current_user.name
  end

  def new_cancellation_field(symbol)
    params[:cancellation] ? params[:cancellation][symbol] : nil
  end

  def last_instrument_used
    last_cancellation_instrument = current_user.created_cancellations.first.try(:instrument)
    new_cancellation_field(:instrument) || last_cancellation_instrument  || ""
  end

  def next_hour_available
    times[times_array_index][1]
  end

  def eval_time
    h = Time.now.hour
    m = Time.now.min
    eval_hour = (h - 9) * 2 + 1
    eval_minute = m / 30
    eval_hour + eval_minute
  end

  def times_array_index
    return 0 if eval_time < 0
    return 0 if eval_time > 23
    eval_time
  end

  def next_date_formatted
    next_date_available.strftime("%m/%d/%y")
  end

  def next_date_available
    return (Time.now.beginning_of_day + 2.days) if eval_time > 23
    Time.now.beginning_of_day + 1.day
  end
  
  def name_example
    Faker::Name.name 
  end

  def instrument_example
    ["Guitar", "Piano", "Voice", "Clarinet"].sample
  end

  def formatted_time_now
    Time.now.strftime("%m/%d/%y")
  end
  
  # custom options for this calendar
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >"
    }
    end

    def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/cancellations/#{event.id}/edit" title="#{h(event.instrument)}">#{h(event.instrument)} #{h(event.get_time)} #{"RESERV" unless event.available?}</a>) 

    end
  end

  def taken_time(user, index)
    cancellation = user.taken_cancellations[index]
    "#{cancellation.get_date} #{cancellation.get_time}" if cancellation
  end
end

