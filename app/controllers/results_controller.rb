class ResultsController < ApplicationController
  layout 'application'

  def show
    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @bm_index = City.where(name: @destination)[0].bm_index
    hotwire_flight_hash = Hotwire.get_flight_info(hash)
    @avg_price = hotwire_flight_hash[:avg_price]
    @max_temp = hotwire_flight_hash[:max_temp]
    @min_temp = hotwire_flight_hash[:min_temp]
    @avg_precipitation = hotwire_flight_hash[:precipitation]
    @photos = Photo.get_photos(params)
    hotwire_hotel_hash = Hotwire.get_hotel_info(hash)
    @low_hotel_price = hotwire_hotel_hash[:low_price]
    @high_hotel_price = hotwire_hotel_hash[:high_price]
    @avg_hotel_price = hotwire_hotel_hash[:avg_hotel_price]
    distance_hash = Hotwire.get_distance(hash)
    @distance = distance_hash[:distance].to_i
  end

end
