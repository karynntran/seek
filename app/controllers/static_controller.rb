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
    hotwire_hash = Hotwire.get_flight_info(hash)
    @avg_price = hotwire_hash[:avg_price]
    @max_temp = hotwire_hash[:max_temp]
    @min_temp = hotwire_hash[:min_temp]
    @avg_precipitation = hotwire_hash[:precipitation]
  end
end
