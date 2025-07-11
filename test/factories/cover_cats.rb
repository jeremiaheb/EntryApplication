FactoryBot.define do
  factory :cover_cat do
    sequence(:name) { |n| "#{Faker::Creature::Animal.name}-#{n}" }
    code { name[0..4].upcase }
    common { name.upcase }
    proofing_code { name }
    rank { 1 }
  end
end
