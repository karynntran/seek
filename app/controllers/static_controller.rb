class StaticController < ApplicationController
  layout 'show'
  layout 'application'

  def index
  end

  def show
    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    hotwire_hash = Hotwire.get_flight_info(hash)
    @avg_price = hotwire_hash[:avg_price].to_s
    @max_temp = hotwire_hash[:max_temp].to_s
    @min_temp = hotwire_hash[:min_temp].to_s
    @avg_precipitation = hotwire_hash[:precipitation].to_s
    render :layout => 'show'
  end
end
