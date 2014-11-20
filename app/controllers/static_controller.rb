class StaticController < ApplicationController
  include
  def index
  end

  def show

    render :layout => false

    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @average_flight_price= Hotwire.get_flight_info(hash)

  end
end
