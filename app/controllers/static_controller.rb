class StaticController < ApplicationController
  def index
  end

  def show
    binding.pry
    origin = params[:origin]
  end
end
