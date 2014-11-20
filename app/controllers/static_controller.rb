class StaticController < ApplicationController
  include
  def index
  end

  def show
    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @average_flight_price= Hotwire.get_flight_info(hash)
  end
end
