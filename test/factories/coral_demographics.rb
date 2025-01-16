FactoryGirl.define do
  factory :coral_demographic do
    boatlog_manager
    diver
    sequence(:buddy)              { |n| "buddy#{n}" }
    field_id "10011A"
    sequence(:meters_completed)
    sequence(:sample_begin_time)  { |n| Time.current }
    sequence(:sample_date)        { |n| Time.current }
    habitat_type
    demographic_corals            { build_list :demographic_coral, 1 }
    sequence(:percent_hardbottom)
  end
end
