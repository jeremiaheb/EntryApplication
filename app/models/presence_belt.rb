class PresenceBelt < ActiveRecord::Base
  ENUM_VALUES = {
    "Absent"           => 0,
    "Present_Transect" => 1, 
    "Present_Site"     => 2,
    "Did Not Look"     => 3 
  }

  belongs_to :benthic_cover

  validates :a_palmata,         :presence => true
  validates :a_cervicornis,     :presence => true
  validates :d_cylindrus,       :presence => true
  validates :m_ferox,           :presence => true
  validates :m_annularis,       :presence => true
  validates :m_franksi,         :presence => true
  validates :m_faveolata,       :presence => true
 
  enum a_palmata:  ENUM_VALUES,
    a_cervicornis: ENUM_VALUES,
    d_cylindrus:   ENUM_VALUES,
    m_ferox:       ENUM_VALUES,
    m_annularis:   ENUM_VALUES,
    m_franksi:     ENUM_VALUES,
    m_faveolata:   ENUM_VALUES,
    _prefix:       true,
    _suffix:       false
end
