FactoryBot.define do
  factory :cover_cat do
    name { Faker::Creature::Animal.name }
    code { name[0..4].upcase }
    common { name.upcase }
    proofing_code { name }
    rank { 1 }
  end
end
