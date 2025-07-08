FactoryBot.define do
  factory :demographic_coral do
     sequence(:meter_mark)
     max_diameter           { 1 }
     perpendicular_diameter { 1 }
     height                 { 1 }
     old_mortality          { 1 }
     recent_mortality       { 1 }
     bleach_condition       { 1 }
     disease                { 1 }
  end
end
