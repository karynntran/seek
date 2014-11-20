module HotWire
  def self.get_flight_info(options)
    origin_city = options[:origin]
    destination = options[:destination]
    month = Date::MONTHNAMES.index(options[:month])
    url = "http://api.hotwire.com/v1/tripstarter/air?apikey=sw32n4fn2u93rqan8cg92f3x&origin=#{origin_city}&dest=#{destination}&startdate=#{month}/1/2013&enddate=#{month}/31/2013"
    api_response = HTTParty.get(url)
    array_of_flights = api_response["Hotwire"]["Result"]["AirPricing"]
  end

  def self.api_key
    ENV['HotWire']
  end

  def self.average_price(arr)
    averages = arr.map do |flight|
      flight["AveragePrice"].to_i
    end
    @avg = (averages.reduce(:+)/averages.length)
  end
end
