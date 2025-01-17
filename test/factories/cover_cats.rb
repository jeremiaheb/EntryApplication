FactoryGirl.define do
  factory :cover_cat do
    name { Faker::Creature::Animal.name }
    code { name[0..2] }
    common "Fake Other"
  end
end
