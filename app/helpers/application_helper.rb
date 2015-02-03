module ApplicationHelper

  def full_title(page_title)
    basic_title = "Makeup Scheduler"

    return basic_title if page_title.empty?
    "#{basic_title} | #{page_title}"
    
  end

# ======================== #
#  time formatting helpers #
# ======================== #

  def next_date_formatted
    next_date_available.strftime("%m/%d/%y")
  end

  def next_date_available
    return (Time.now.beginning_of_day + 2.days) if eval_time > 23
    Time.now.beginning_of_day + 1.day
  end

  def formatted_time_now
    Time.now.strftime("%m/%d/%y")
  end

  def taken_time(user, index)
    cancellation = user.taken_cancellations[index]
    "#{cancellation.get_date} #{cancellation.get_time}" if cancellation
  end

  def current_year
    Time.now.year
  end

  def current_month
    Time.now.month
  end

  def current_date_url_matcher
    "#{current_year}/#{current_month}"
  end
end


# p full_title("About") == "Makeup Scheduler | About"
# p full_title("Home") == "Makeup Scheduler | Home"
# p full_title('')  == "Makeup Scheduler"