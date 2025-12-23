FactoryBot.define do
  factory :demographic_coral do
     sequence(:meter_mark)
     juvenile               { false }
     max_diameter           { 5 }
     perpendicular_diameter { 4 }
     height                 { 1 }
     old_mortality          { 0 }
     recent_mortality       { 0 }
     bleach_condition       { "N" }
     disease                { "absent" }
     restored               { :not_restored }

     trait :juvenile do
       juvenile { true }
       max_diameter { nil }
       perpendicular_diameter { nil }
       height { 5 }
       old_mortality { nil }
       recent_mortality { nil }
       bleach_condition { nil }
       disease { nil }
       restored { nil }
     end
  end
end
