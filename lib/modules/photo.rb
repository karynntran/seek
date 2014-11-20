module Photo

  def self.get_photos(options)
    lat_long = City.find_by(name: options[:destination])
    url_hash = {}
    url_hash[:latitutde] = lat_long.split(',')[0]
    url_hash[:longitude] = lat_long.split(',')[1]
    get_api_ids(url_hash)
  end

  def self.get_api_ids(options)
    latitude = options[:latitude]
    longitude = options[:longitude]
    api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=63cc42384b112fe6bd9597dd5e25cc0f&lat=#{latitude}&lon=#{longitude}&format=rest")
    get_api_ids(api)
  end

  def self.get_api_urls(api)
    all_location_photos = api["rsp"]["photos"]["photo"]

    all_photo_ids = all_location_photos.map do |photo|
      photo["id"]
    end

    all_photo_urls = all_photo_ids.map do |photo_id|

      url_call = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=63cc42384b112fe6bd9597dd5e25cc0f&photo_id=#{photo_id}&format=rest")

      url_call["rsp"]["sizes"]["size"][4]["source"]
    end

    imgs = all_photo_urls.each do |url|
      "<img width='100px' height='auto' src='#{url}'>"
    end
  end

end