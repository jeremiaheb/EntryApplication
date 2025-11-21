FactoryBot.define do
  factory :boat_log do
    mission
    primary_sample_unit { "1234" }
    date { Date.parse("2014-02-02") }
  end
end
