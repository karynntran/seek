class StaticController < ApplicationController
  def index
  end

  def show
    render :layout => false
  end
end
