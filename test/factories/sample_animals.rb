FactoryBot.define do
  factory :sample_animal do
    sample
    animal
    number_individuals { 1 }
    average_length { 15 }
    time_seen { 1 }
  end
end
