class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def fallback
    flash[:danger] = "That URL doesn't exist"
    redirect_to root_path
  end
end
