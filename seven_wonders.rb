require 'httparty'
require "awesome_print"

BASE_URL = "https://us1.locationiq.com/v1/search.php"
LOCATION_IQ_KEY = "pk.3464ab3a561c628e94fff8b7e99e3261"

def get_location(search_term)
  response = HTTParty.get(BASE_URL, query: {
      q: "#{search_term}",
      key: LOCATION_IQ_KEY,
      format: 'json'
  }
  )

  return response
end

# def find_seven_wonders
#
#   seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]
#
#   seven_wonders_locations = []
#
#
#   seven_wonders.each do |wonder|
#     sleep(0.5)
#     seven_wonders_locations << get_location(wonder)
#   end
#
#   return seven_wonders_locations
# end

def find_seven_wonders

  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders_hash = {}

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end


  i=0
    seven_wonders.each do |wonder|
      sleep(0.6)
      if get_location(wonder).code == 200
        # puts "#{wonder}"
        # puts "#{get_location(wonder).first["lat"]}"
        # sleep(0.6)
        # puts "#{get_location(wonder).first["lon"]}"
        seven_wonders_hash[wonder] = {
            "lat" => seven_wonders_locations[i].first["lat"],
            "lon" => seven_wonders_locations[i].first["lon"]
          }
        i += 1
      end
    end

  # puts "#########"
  # # puts "#{seven_wonders_hash}"
  # puts "#########"
  #return seven_wonders_locations
  return seven_wonders_hash
end

# def print(locations)
#   hash_to_print = {}
#   locations.each do |wonder|
#
#     hash_to_print[wonder["display"]] = {
#         "lat" => wonder.first["lat"],
#         "lon" => wonder.first["lon"]
#     }
#   end
#
#     return hash_to_print
#
# end

# Use awesome_print because it can format the output nicely
pp find_seven_wonders
# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]
