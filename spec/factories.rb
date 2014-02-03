FactoryGirl.define do
  factory :animal do
    species_code "MY_FISH"
    scientific_name "Myus fishius"
    common_name "My Fish"
    max_size 100
    min_size 10
    max_number 200
  end

  factory :benthic_cover do
    sequence(:boatlog_manager_id)
    sequence(:diver_id)
    sequence(:buddy)
    sample_date { Date.parse("2013-09-15") }
    sample_begin_time { Time.parse("2013-09-15T15:00:00Z") }
    field_id "10011A"
    habitat_type
    meters_completed 20
    sample_description "Here is my sample"
  end

  factory :coral do
    code "ACR PALM"
    scientific_name "Acropora palmata"
  end

  factory :coral_demographic do
    sequence(:boatlog_manager_id)
    sequence(:buddy)              { |n| "buddy#{n}" }
    sequence(:diver_id)
    sequence(:field_id)           { |n| "field_id#{n}" }
    sequence(:meters_completed)
    sequence(:sample_begin_time)  { |n| Time.current }
    sequence(:sample_date)        { |n| Time.current }
    habitat_type
    demographic_corals            { build_list :demographic_coral, 1 }
  end

  factory :cover_cat do
    name "sand"
  end

  factory :demographic_coral do
     max_diameter           { 1 }
     perpendicular_diameter { 1 }
     height                 { 1 }
     old_mortality          { 1 }
     recent_mortality       { 1 }
     bleach_condition       { 1 }
  end

  factory :diver do
    sequence(:diver_number) { |n| "diver#{n}" }
    sequence(:diver_name)   { |n| "Random Diver#{n}" }
    sequence(:email)        { |n| "diver#{n}@example.com" }
    sequence(:password)     { |n| "password#{n}" }
  end

  factory :habitat_type do
    habitat_name "Sand"
    habitat_description "This is sand"
  end

  factory :sample_type do
    sample_type_name "Bohnsack"
    sample_type_description "Circular point count"
  end

  factory :boatlog_manager do
    agency "NOAA"
    firstname "Jeremiah"
    lastname "Blondeau"
  end

  factory :boat_log do
    boatlog_manager
    primary_sample_unit "1001"
    date Date.parse("2014-02-02")
  end

  factory :station_log do
    boat_log
    stn_number "1"
    time Time.parse("2014-02-02T15:00:00Z")
    latitude "25.12345"
    longitude "-81.12345"
    comments "station 1"
  end

  factory :rep_log do
    station_log
    diver
    replicate "A"
  end

end
