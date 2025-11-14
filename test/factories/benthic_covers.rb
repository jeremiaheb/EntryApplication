FactoryBot.define do
  factory :benthic_cover do
    mission
    diver
    buddy factory: :diver
    sample_date { Date.parse("2013-09-15") }
    sample_begin_time { Time.parse("2013-09-15T15:00:00Z") }
    field_id { "10011a" }
    habitat_type
    meters_completed { 20 }
    sample_description { "Here is my sample" }
    presence_belt
  end

  factory :presence_belt do
    a_palmata { PresenceBelt::ENUM_VALUES.keys.sample }
    a_cervicornis { PresenceBelt::ENUM_VALUES.keys.sample }
    d_cylindrus { PresenceBelt::ENUM_VALUES.keys.sample }
    m_ferox { PresenceBelt::ENUM_VALUES.keys.sample }
    m_annularis { PresenceBelt::ENUM_VALUES.keys.sample }
    m_franksi { PresenceBelt::ENUM_VALUES.keys.sample }
    m_faveolata { PresenceBelt::ENUM_VALUES.keys.sample }
  end
end
