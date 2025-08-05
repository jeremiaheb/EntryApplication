FactoryBot.define do
  factory :habitat_type do
    habitat_name { "Sand" }
    habitat_description { "This is sand" }
    region { HabitatType::VALID_REGIONS.sample }
  end
end
