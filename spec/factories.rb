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
    boatlog_manager
    diver
    sequence(:buddy)
    sample_date { Date.parse("2013-09-15") }
    sample_begin_time { Time.parse("2013-09-15T15:00:00Z") }
    field_id "10011a"
    habitat_type
    meters_completed 20
    sample_description "Here is my sample"
  end

  factory :point_intercept do
    benthic_cover
    cover_cat
    hardbottom_num 25
    softbottom_num 50
    rubble_num nil
  end
  
  factory :cover_cat do
    code "POF SPE."
    name "Porifera spp"
    common "Sponges other"
  end

  factory :rugosity_measure do
    benthic_cover
    min_depth 50
    max_depth 55
    rug_meters_completed 15
    meter_mark_1 15
    meter_mark_2 10
    meter_mark_3 10  
    meter_mark_4 15 
    meter_mark_5 20 
    meter_mark_6 10 
    meter_mark_7 1 
    meter_mark_8 15
    meter_mark_9 10 
    meter_mark_10 4 
    meter_mark_11 5
    meter_mark_12 10
    meter_mark_13 15
    meter_mark_14 20
    meter_mark_15 10
    
  end

  factory :coral do
    code "ACR PALM"
    scientific_name "Acropora palmata"
  end

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


  factory :demographic_coral do
     sequence(:meter_mark)
     max_diameter           { 1 }
     perpendicular_diameter { 1 }
     height                 { 1 }
     old_mortality          { 1 }
     recent_mortality       { 1 }
     bleach_condition       { 1 }
     disease                { 1 }
  end

  factory :diver do
    sequence(:diver_number) { |n| "diver#{n}" }
    sequence(:diver_name) { |n| "Random Diver#{n}" }
    sequence(:username) { |n| "diver#{n}" }
    sequence(:email) { |n| "diver#{n}@example.com" }
    sequence(:password) { |n| "password#{n}" }
    role { "diver" }
  end

  factory :habitat_type do
    habitat_name "Sand"
    habitat_description "This is sand"
    region "Atlantic"
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
    primary_sample_unit "1234"
    date Date.parse("2014-02-02")
  end

  factory :station_log do
    boat_log
    stn_number "2"
    time Time.parse("2014-02-02T15:00:00Z")
    latitude "25.12345"
    longitude "-81.12345"
    comments "station 1"
  end

  factory :rep_log do
    station_log
    diver
    replicate "j"
  end

  factory :sample do
    sample_type
    habitat_type
    boatlog_manager
    sample_date Date.parse("2014-02-02")
    dive_begin_time Time.parse("2014-02-02T09:00:00Z")
    dive_end_time Time.parse("2014-02-02T09:45:00Z")
    sample_begin_time Time.parse("2014-02-02T09:05:00Z")
    sample_end_time Time.parse("2014-02-02T09:30:00Z")
    dive_depth 45
    sample_depth 45
    fishing_gear "none"
    field_id "10011a"
    underwater_visibility 50
    sample_description "none"
    sand_percentage 25
    hardbottom_percentage 75
    rubble_percentage 0
    water_temp 80
    current "none"
    substrate_max_depth 50
    substrate_min_depth 50
    hard_verticle_relief 1
    soft_verticle_relief 1
    hard_relief_cat_0 20
    hard_relief_cat_1 20
    hard_relief_cat_2 20
    hard_relief_cat_3 20
    hard_relief_cat_4 20
    soft_relief_cat_0 0
    soft_relief_cat_1 0
    soft_relief_cat_2 100
    soft_relief_cat_3 0 
    soft_relief_cat_4 0
    sand_bare 100
    sand_macro_algae 0
    sand_seagrass 0
    sand_sponge 0
    sand_pcov_other1_lab "none"
    sand_pcov_other2_lab "none"
    sand_pcov_other1 0
    sand_pcov_other2 0 
    hardbottom_algal_turf 25
    hardbottom_macro_algae 50
    hardbottom_live_coral 5
    hardbottom_octocoral 5
    hardbottom_sponge 5
    hard_pcov_other1_lab "Palythoa"
    hard_pcov_other2_lab "none"
    hard_pcov_other1 10
    hard_pcov_other2 0

  end

  factory :diver_sample do
    diver
    sample
    primary_diver true
  end

  factory :sample_animal do
    sample
    animal
    number_individuals 1
    average_length 15
  end

end
