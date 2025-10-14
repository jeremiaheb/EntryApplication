class PresenceBelt < ApplicationRecord
  ENUM_VALUES = {
    "Absent"           => 0,
    "Present_Transect" => 1,
    "Present_Site"     => 2,
    "Did Not Look"     => 3,
  }

  belongs_to :benthic_cover

  validates :a_palmata,         presence: true
  validates :a_cervicornis,     presence: true
  validates :d_cylindrus,       presence: true
  validates :m_ferox,           presence: true
  validates :m_annularis,       presence: true
  validates :m_franksi,         presence: true
  validates :m_faveolata,       presence: true

  enum :a_palmata,     ENUM_VALUES, instance_methods: false
  enum :a_cervicornis, ENUM_VALUES, instance_methods: false
  enum :d_cylindrus,   ENUM_VALUES, instance_methods: false
  enum :m_ferox,       ENUM_VALUES, instance_methods: false
  enum :m_annularis,   ENUM_VALUES, instance_methods: false
  enum :m_franksi,     ENUM_VALUES, instance_methods: false
  enum :m_faveolata,   ENUM_VALUES, instance_methods: false
end
