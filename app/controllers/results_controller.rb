class ResultsController < ApplicationController
  layout 'application'

  # holy mother of mono-method
  # each method should do just one thing.
  # A controller should do the following things:
  # 1. deal with incoming data
  # 2. pass off the data to some other object to do work
  # 3. send the user to the right place / display the right thing

  # Everything in the "else" should at least be its own method, if not its own
  # object. In addition, there are simply too many instance variables.
  # Even if it feels hackish, grouping them together helps.
  # Clearly there is a "@loc_data" object of some sort (name not definitive)

  def show
    @user = User.new
    @origin = params[:origin]
    @destination = params[:destination]
    @month = params[:month]
    hash = {destination: @destination, origin: @origin, month: @month}
    @bm_index = City.where(name: @destination)[0].bm_index
    hotwire_flight_hash = Hotwire.get_flight_info(hash)

    # These two seem to always come together. If this is a presentation concern
    # (aka HTML / Javascript), maybe it should go in a helper?
    @origins = City.where(origin: true).map{ |city| city.name }
    @destinations = City.all.map{ |city| city.name }

    if hotwire_flight_hash == "failed"
        flash.now[:error] = "Unfortunately, We could not find any flights to your destination.  Please search for another."
        flash.keep(:error)
        redirect_to root_path
    else
        @avg_price = hotwire_flight_hash[:avg_price]
        @max_temp = hotwire_flight_hash[:max_temp]
        @min_temp = hotwire_flight_hash[:min_temp]
        @avg_precipitation = hotwire_flight_hash[:precipitation]
        @photos = Photo.get_photos(params)
        hotwire_hotel_hash = Hotwire.get_hotel_info(hash)
        @low_hotel_price = hotwire_hotel_hash[:low_price]
        @high_hotel_price = hotwire_hotel_hash[:high_price]
        @avg_hotel_price = hotwire_hotel_hash[:avg_hotel_price]
        # Instead of doing the searches every time, and even though Rails will
        # cache the result, so the search does not actually go to the DB,
        # it's usually better to give those a name with a variable.
        # it improves readability of the code.
        origin_lat = City.where(name: @origin)[0].lat_long.split(',')[0].to_f
        origin_long = City.where(name: @origin)[0].lat_long.split(',')[1].to_f
        destination_lat = City.where(name: @destination)[0].lat_long.split(',')[0].to_f
        destination_long = City.where(name: @destination)[0].lat_long.split(',')[1].to_f
        @distance = Haversine.distance(origin_lat, origin_long, destination_lat, destination_long).to_miles.to_i
        zone = NearestTimeZone.to(destination_lat, destination_long)
        @time = Time.now.in_time_zone(zone).strftime("%l:%M%p")
    end
  end

end
