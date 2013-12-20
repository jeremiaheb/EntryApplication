FactoryGirl.define do
  factory :animal do
    species_code "MY_FISH"
    scientific_name "Myus fishius"
    common_name "My Fish"
    max_size 100
    min_size 10
    max_number 200
  end

  factory :coral do
    code "ACR PALM"
    scientific_name "Acropora palmata"
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

end
