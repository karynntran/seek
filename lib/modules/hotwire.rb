module Hotwire

  def self.get_hotel_info(options)
    destination = City.find_by(name: options[:destination]).airport
    url = "http://api.hotwire.com/v1/deal/hotel?apikey=#{api_key}&dest=#{destination}"
    api_response = HTTParty.get(url)
    array_of_hotels = api_response["Hotwire"]["Result"]["HotelDeal"]
    avg_price = average_hotel_price(array_of_hotels)
    high_price = high_price(array_of_hotels)
    low_price = low_price(array_of_hotels)
    hotwire_hotel_hash = Hash[avg_hotel_price: avg_price, low_price: low_price, high_price: high_price]
  end

  def self.get_flight_info(options)
    origin_city = City.find_by(name: options[:origin]).airport
    destination = City.find_by(name: options[:destination]).airport
    month = Date::MONTHNAMES.index(options[:month])
    year = Time.now.year - 1
    days = Time.days_in_month(month, year)
    url = "http://api.hotwire.com/v1/tripstarter/air?apikey=#{api_key}&origin=#{origin_city}&dest=#{destination}&startdate=#{month}/1/#{year}&enddate=#{month}/#{days}/#{year}"
    api_response = HTTParty.get(url)
      if api_response['Hotwire']['Result'] == nil
        return "failed"
      else
        parsed_response = api_response["Hotwire"]["Result"]["AirPricing"]
        if parsed_response.class == Hash
          avg_price = hash_average_flight_price(parsed_response)
          max_temp = hash_max_temp(parsed_response)
          min_temp = hash_min_temp(parsed_response)
          precipitation = hash_precipitation(parsed_response)
        else
          avg_price = average_flight_price(parsed_response)
          max_temp = max_temp(parsed_response)
          min_temp = min_temp(parsed_response)
          precipitation = precipitation(parsed_response)
        end
      end
    hotwire_hash = Hash[avg_price: avg_price, max_temp: max_temp, min_temp: min_temp, precipitation: precipitation]
  end

  def self.api_key
    ENV['HotWire']
  end

  def self.hash_average_flight_price(hash)
    average = hash["AveragePrice"].to_i
  end

  def self.hash_max_temp(hash)
      hash["AverageMaxTemp"].to_i
  end

  def self.hash_min_temp(hash)
      hash["AverageMinTemp"].to_i
  end

  def self.hash_precipitation(hash)
      hash["AveragePrecipitationInches"].to_i
  end

  def self.average_hotel_price(arr)
    averages = arr.map do |hotel|
      hotel["Price"].to_i
    end
    averages.reduce(:+)/averages.length
  end

  def self.high_price(arr)
    prices = arr.map { |hotel| hotel["Price"].to_i }
    prices.max
  end

  def self.low_price(arr)
    prices = arr.map { |hotel| hotel["Price"].to_i }
    prices.min
  end

  def self.average_flight_price(arr)
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
