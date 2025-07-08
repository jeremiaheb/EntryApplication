FactoryBot.define do
  factory :station_log do
    boat_log
    stn_number { "2" }
    time { Time.parse("2014-02-02T15:00:00Z") }
    latitude { "25.12345" }
    longitude { "-81.12345" }
    comments { "station 1" }
  end
end
