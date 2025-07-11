FactoryBot.define do
  factory :coral do
    sequence(:scientific_name) { |n| "#{Faker::Creature::Animal.name}-#{n}" }
    code { scientific_name[0..4].upcase }
    short_code { scientific_name[0..2].upcase }
    rank { 1 }
  end
end
