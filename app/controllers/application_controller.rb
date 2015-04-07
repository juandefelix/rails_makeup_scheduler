class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?

  def redirect_to_home_if_not_signed_in
    redirect_to new_user_session_path unless signed_in?
  end

  def check_admin_role
    redirect_to root_url unless current_user.has_role?(:admin)
  end

  def get_date_time
    date_and_time = params[:date] + " " + params[:cancellation][:start_at]
    date_and_time_array = date_and_time.split(/[\D]/)

    year = date_and_time_array[2].blank? ? "2000" : ("20" + date_and_time_array[2])
    month = date_and_time_array[0].blank? ? "01" : date_and_time_array[0]
    day = date_and_time_array[1].blank? ? "01" : date_and_time_array[1]
    hour = date_and_time_array[3]  || "12"
    minute = date_and_time_array[4]  || "00"

    Time.local(year, month, day, hour, minute)
  end
  
  def find_cancellation
    @cancellation = Cancellation.find(params[:id])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
