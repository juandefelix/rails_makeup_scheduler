include ApplicationHelper


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


def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
   visit "/auth/facebook"
  end
end