module Photo

  def self.get_api_urls(options)
    latitude = options[:latitude]
    longitude = options[:longitude]
    api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=8701c7d581eab20399c7d2b7599918ff&lat=#{latitude}&lon=#{longitude}&format=rest")

    all_location_photos = api.first[1]["photos"]["photo"]

    all_photo_ids = all_location_photos.map do |photo|
      photo["id"]
    end

    all_photo_urls = all_photo_ids.map do |photo_id|

      url_call = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=8701c7d581eab20399c7d2b7599918ff&photo_id=#{photo_id}&format=rest")

      url_call["rsp"]["sizes"]["size"][4]["source"]
    end

    imgs = all_photo_urls.each do |url|
      "<img width='100px' height='auto' src='#{url}'>"
    end
  end

end