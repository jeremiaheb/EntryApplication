FactoryGirl.define do
  factory :coral do
    scientific_name { Faker::Creature::Animal.name }
    code { scientific_name[0..2].upcase }
  end
end
