module Photo

  def self.get_photos(options)
    lat_long = City.find_by(name: options[:destination]).lat_long

    api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=63cc42384b112fe6bd9597dd5e25cc0f&lat=#{lat_long.split(',')[0]}&lon=#{lat_long.split(',')[1]}&format=rest&safe_search=1&extras=url_c&sort=interestingness-desc")

    photo_array = api['rsp']['photos']['photo'].map do |photo|
      photo['url_c'] ? photo['url_c'] : nil
    end.compact

    photo_array.length > 15 ? photo_array[0..15] : photo_array
  end
end


