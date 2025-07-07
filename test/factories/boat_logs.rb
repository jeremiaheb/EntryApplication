FactoryGirl.define do
  factory :boat_log do
    boatlog_manager
    primary_sample_unit "1234"
    date Date.parse("2014-02-02")
  end
end
