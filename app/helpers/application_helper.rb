module ApplicationHelper

  def full_title(page_title)
    basic_title = "Makeup Scheduler"

    return basic_title if page_title.empty?
    "#{basic_title} | #{page_title}"
    
  end
end


# p full_title("About") == "Makeup Scheduler | About"
# p full_title("Home") == "Makeup Scheduler | Home"
# p full_title('')  == "Makeup Scheduler"