class Photo < ActiveRecord::Base

def get_api_urls
  api = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=8701c7d581eab20399c7d2b7599918ff&lat=48.8567&lon=2.3508&format=rest")

  all_paris_photos = api.first[1]["photos"]["photo"]

  all_paris_ids = all_paris_photos.map do |photo|
    photo["id"]
  end

  all_paris_urls = all_paris_ids.map do |photo_id|

    url_call = HTTParty.get("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=8701c7d581eab20399c7d2b7599918ff&photo_id=#{photo_id}&format=rest")

    url_call["rsp"]["sizes"]["size"][4]["source"]
  end

  imgs = all_paris_urls.each do |url|
    "<img width='100px' height='auto' src='#{url}'>"
  end
end