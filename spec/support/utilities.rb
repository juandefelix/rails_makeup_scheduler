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

# this was created with the for the initial version of the app based on Michael Hartl's tutorial
# def sign_in(options={})
#   if options[:no_capybara]
#     # Sign in when not using Capybara
#     remember_token = User.new_remember_token
#     cookies[:remember_token] = remember_token
#     user.update_attribute(:remember_token, User.hash(remember_token))
#   else
#     visit root_path
#     visit "/auth/facebook"
#     @user = User.first
#   end
# end

def admin_sign_in
  visit '/auth/facebook'
  User.find_by_provider_and_uid('facebook', '1337').add_role :admin
  visit root_path
end

def sign_in
  visit '/auth/facebook'
end