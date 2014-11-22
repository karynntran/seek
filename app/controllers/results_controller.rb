class ResultsController < ApplicationController
  layout 'application'

  def show
    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @bm_index = City.where(name: @destination)[0].bm_index
    hotwire_hash = Hotwire.get_flight_info(hash)
    @avg_price = hotwire_hash[:avg_price].to_s
    @max_temp = hotwire_hash[:max_temp].to_s
    @min_temp = hotwire_hash[:min_temp].to_s
    @avg_precipitation = hotwire_hash[:precipitation].to_s
    @photos = Photo.get_photos(params)

  end

end
