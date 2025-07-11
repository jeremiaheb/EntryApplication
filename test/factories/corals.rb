FactoryBot.define do
  factory :coral do
    scientific_name { Faker::Creature::Animal.name }
    code { scientific_name[0..4].upcase }
    short_code { scientific_name[0..2].upcase }
    rank { 1 }
  end
end
