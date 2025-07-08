FactoryBot.define do
  factory :point_intercept do
    benthic_cover
    cover_cat
    hardbottom_num { 25 }
    softbottom_num { 50 }
    rubble_num { nil }
  end
end
