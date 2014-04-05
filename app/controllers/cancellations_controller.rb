class CancellationsController < ApplicationController

  def new
    @cancellation = Cancellation.new
  end

  def create
    redirect_to @cancellation
  end
  
  def destroy
  end

  def show
  end
end
