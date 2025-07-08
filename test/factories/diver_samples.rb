FactoryBot.define do
  factory :diver_sample do
    diver
    sample
    primary_diver { true }
  end
end
