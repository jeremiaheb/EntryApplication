FactoryBot.define do
  factory :mission do
    project
    agency
    region
    active { true }
  end
end
