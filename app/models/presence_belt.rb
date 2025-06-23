class PresenceBelt < ActiveRecord::Base
  ENUM_VALUES = {
    "Absent"           => 0,
    "Present_Transect" => 1, 
    "Present_Site"     => 2,
    "Did Not Look"     => 3 
  }

  belongs_to :benthic_cover

  enum :a_palmata, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :a_cervicornis, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :d_cylindrus, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :m_ferox, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :m_annularis, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :m_franksi, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
  enum :m_faveolata, ENUM_VALUES,
    validate: true,
    scopes: false,
    instance_methods: false
end
