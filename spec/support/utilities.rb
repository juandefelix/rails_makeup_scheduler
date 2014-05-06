
  def full_title(page_title)
    base_title = "Makeup Scheduler"
    return base_title if page_title.empty?
    "#{base_title} | #{page_title}"
  end

  def future_date
    (Time.now + 2.day).strftime("%m/%d/%y")
  end

  def past_date
    (Time.now - 1.day).strftime("%m/%d/%y")
  end
