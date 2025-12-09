FactoryBot.define do
  factory :tally_mark do
    benthic_cover
    cover_cat
    meter_mark { ["0.00", "0.15", "0.30"].sample }
    habitat { ["H", "S", "R"].sample }
  end
end
