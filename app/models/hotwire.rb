module HotWire

  def self.get_flight_info(options)
    origin_city = options[:origin]
    destination = options[:destination]
    month = Date::MONTHNAMES.index(options[:month])
    url = "http://api.hotwire.com/v1/tripstarter/air?apikey=#{api_key}&origin=#{origin_city}&dest=#{destination}&startdate=#{month}/1/2013&enddate=#{month}/31/2013"
    @api_response = HTTParty.get(url)
  end

  def self.api_key
    ENV['HotWire']
  end
end
