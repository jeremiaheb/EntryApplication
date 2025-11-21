FactoryBot.define do
  factory :diver do
    sequence(:diver_number) { |n| "diver#{n}" }
    sequence(:diver_name) { |n| "Random Diver#{n}" }
    sequence(:username) { |n| "diver#{n}" }
    sequence(:email) { |n| "diver#{n}@example.com" }
    email_confirmed { true }
    sequence(:password) { |n| "password#{n}" }
    role { "diver" }
    active { true }
  end
end
