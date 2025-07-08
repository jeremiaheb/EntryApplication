FactoryBot.define do
  factory :cover_cat do
    name { Faker::Creature::Animal.name }
    code { name[0..2].upcase }
    common { name.upcase }
  end
end
