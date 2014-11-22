# class StaticController < ApplicationController
#   layout 'show'
#   layout 'application'
#   # layout 'photos'

#   # def index
#   #   @user = User.new
#   #   render :layout => 'application'
#   # end

#   # def autocomplete
#   #   origin = City.where(origin: true).map{ |city| city.name }
#   #   destination = City.all.map{ |city| city.name }

#   #   respond_to do |format|
#   #     format.json { render :json => { origin: origin, destination: destination } }
#   #   end
#   # end

#   # def show
#   #   @origin = params[:origin]
#   #   @destination = params[:destination]
#   #   @month = params[:month]
#   #   hash = {destination: @destination, origin: @origin, month: @month}
#   #   @bm_index = City.where(name: @destination)[0].bm_index
#   #   hotwire_hash = Hotwire.get_flight_info(hash)
#   #   @avg_price = hotwire_hash[:avg_price].to_s
# #   #   @max_temp = hotwire_hash[:max_temp].to_s
# #   #   @min_temp = hotwire_hash[:min_temp].to_s
# #   #   @avg_precipitation = hotwire_hash[:precipitation].to_s
# #   #   @photos = Photo.get_photos(params)
# #   #   render :layout => 'show'

# #   # end

# #   def photos
# #     render :layout => 'photos'
# #   end
# # end
