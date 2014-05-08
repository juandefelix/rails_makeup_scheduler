module CancellationsHelper
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

  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  def get_time(time_object)
    time_object.strftime("%I:%M%p")
  end

  def get_date_time
    date_and_time = params[:cancellation][:date] + " " + params[:cancellation][:start_at]
    date_and_time_array = date_and_time.split(/[\D]/)

    year = date_and_time_array[2].blank? ? "2000" : ("20" + date_and_time_array[2])
    month = date_and_time_array[0].blank? ? "01" : date_and_time_array[0]
    day = date_and_time_array[1].blank? ? "01" : date_and_time_array[1]
    hour = date_and_time_array[3]  || "12"
    minute = date_and_time_array[4]  || "00"

    Time.new(year, month, day, hour, minute)
  end

  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"    }
  end


  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      %(<a href="/cancellations/#{event.id}" title="#{h(event.instrument)}">#{h(event.instrument)}
        #{h(get_time(event.start_at))}</a>)
    end
  end
end
