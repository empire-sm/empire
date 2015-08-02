# scapi.rb
require "forecast_io"
require "json"

ForecastIO.api_key = "e6a332ffedc339a91bfef1ead30b4101"

forecast    = JSON.pretty_generate(ForecastIO.forecast(40.670158, -73.957765))
parsed      = JSON.parse(forecast)

precip_prob = parsed["currently"]["precipProbability"].to_f
humidity    = parsed["currently"]["humidity"].to_f
cloud_cover = parsed["currently"]["cloudCover"].to_f
wind_speed  = parsed["currently"]["windSpeed"].to_f
temperature = parsed["currently"]["temperature"].to_f
perceived   = parsed["currently"]["apparentTemperature"].to_f
precip_int  = parsed["currently"]["precipIntensity"].to_f

add1  = (wind_speed - cloud_cover).abs
mult1 = (temperature - perceived).abs

File.open("../data.csv","w") do |f|
	f.puts "#{precip_prob},#{humidity},#{cloud_cover},#{wind_speed},#{temperature},#{perceived},#{precip_int},#{add1},#{mult1}"
end
