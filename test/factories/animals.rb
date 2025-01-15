FactoryGirl.define do
  factory :animal do
    species_code "MY_FISH"
    scientific_name "Myus fishius"
    common_name "My Fish"
    max_size 100
    min_size 10
    max_number 200
  end
end
