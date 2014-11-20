module Photo

  def self.get_photos(options)
    lat_long = City.find_by(name: options[:destination]).lat_long

    api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=63cc42384b112fe6bd9597dd5e25cc0f&lat=#{lat_long.split(',')[0]}&lon=#{lat_long.split(',')[1]}&format=rest&safe_search=1&extras=url_c&sort=interestingness-desc")

    photo_array = api['rsp']['photos']['photo'].map do |photo|
      photo['url_c'] ? photo['url_c'] : nil
    end.compact

    photo_array.map do |url|
      "<img width='100px' height='auto' class='destination_photos' src='#{url}'>"
    end
  end
end



#     binding.pry
#     get_api_urls(api)
#   end

#   def self.get_api_urls(api)
#     all_location_photos = api["rsp"]["photos"]["photo"]

#     all_photo_ids = all_location_photos.map do |photo|
#       photo["id"]
#     end
#     binding.pry
#     all_photo_urls = all_photo_ids.map do |photo_id|

#       url_call = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=63cc42384b112fe6bd9597dd5e25cc0f&photo_id=#{photo_id}&format=rest")

#       url_call["rsp"]["sizes"]["size"][4]["source"]
#     end
#     binding.pry
#     imgs = all_photo_urls.each do |url|
#       "<img width='100px' height='auto' src='#{url}'>"
#     end
#   end

# end