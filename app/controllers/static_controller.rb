class StaticController < ApplicationController
  layout 'show'
  layout 'application'

  def index
  end

  def show

    render :layout => 'show'

    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @average_flight_price= Hotwire.get_flight_info(hash)

  end
end
