FactoryGirl.define do
  factory :rep_log do
    station_log
    diver
    replicate Faker::Alphanumeric.alpha(number: 1)
  end
end
