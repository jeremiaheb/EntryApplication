FactoryBot.define do
  factory :mission do
    project_id { 1 }
    agency_id { 1 }
    region_id { 1 }
    active { false }
  end
end
