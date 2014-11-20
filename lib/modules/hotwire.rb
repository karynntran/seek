module Hotwire
  def self.get_flight_info(options)
    origin_city = options[:origin]
    destination = options[:destination]
    month = Date::MONTHNAMES.index(options[:month])
    url = "http://api.hotwire.com/v1/tripstarter/air?apikey=sw32n4fn2u93rqan8cg92f3x&origin=#{origin_city}&dest=#{destination}&startdate=#{month}/1/2013&enddate=#{month}/31/2013"
    api_response = HTTParty.get(url)
    array_of_flights = api_response["Hotwire"]["Result"]["AirPricing"]
    avg_price = average_price(array_of_flights)
    max_temp = max_temp(array_of_flights)
    min_temp = min_temp(array_of_flights)
    precipitation = precipitation(array_of_flights)
    hotwire_hash = Hash[avg_price: avg_price, max_temp: max_temp, min_temp: min_temp, precipitation: precipitation]
  end

  def self.api_key
    ENV['HotWire']
  end

  def self.average_price(arr)
    averages = arr.map do |flight|
      flight["AveragePrice"].to_i
    end
    averages.reduce(:+)/averages.length
  end

  def self.max_temp(arr)
    avg_max_temp = arr.map do |flight|
      flight["AverageMaxTemp"].to_i
    end
    avg_max_temp.reduce(:+)/avg_max_temp.length
  end

  def self.min_temp(arr)
    avg_min_temp = arr.map do |flight|
      flight["AverageMinTemp"].to_i
    end
    avg_min_temp.reduce(:+)/avg_min_temp.length
  end

  def self.precipitation(arr)
    avg_precipitation = arr.map do |flight|
      flight["AveragePrecipitationInches"].to_i
    end
    avg_precipitation.reduce(:+)/avg_precipitation.length
  end
end
