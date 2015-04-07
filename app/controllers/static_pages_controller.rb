class StaticPagesController < ApplicationController
  before_action :redirect_to_home_if_not_signed_in
  
  def home
  end

  def help
  end

  def contact
  end

  def admin_help
  end

  def fallback
    flash[:danger] = "That URL doesn't exist"
    redirect_to root_path
  end
end
