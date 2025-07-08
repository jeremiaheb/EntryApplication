FactoryBot.define do
  factory :benthic_cover do
    boatlog_manager
    diver
    sequence(:buddy)
    sample_date { Date.parse("2013-09-15") }
    sample_begin_time { Time.parse("2013-09-15T15:00:00Z") }
    field_id { "10011a" }
    habitat_type
    meters_completed { 20 }
    sample_description { "Here is my sample" }
  end
end
