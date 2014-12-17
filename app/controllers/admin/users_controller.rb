class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order :name
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end
end
