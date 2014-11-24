module Photo

  def self.get_photos(options)
    lat_long = City.find_by(name: options[:destination]).lat_long
    api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{api_key}&lat=#{lat_long.split(',')[0]}&lon=#{lat_long.split(',')[1]}&format=rest&safe_search=1&extras=url_l&sort=interestingness-desc&orientation=landscape&width=1024&per_page=300")

    photo_array = api['rsp']['photos']['photo'].map do |photo|
      if photo['height_l'].to_i.between?(680, 685)
        photo['url_l'] ? photo['url_l'] : nil
      end
    end.compact

    photo_array.length > 19 ? photo_array[0..19] : photo_array
  end

  def self.api_key
    ENV['Flickr']
  end
end


