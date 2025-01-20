class PresenceBelt < ActiveRecord::Base
  belongs_to :benthic_cover
 
  validates :a_palmata,         :presence => true
  validates :a_cervicornis,     :presence => true
  validates :d_cylindrus,       :presence => true
  validates :m_ferox,           :presence => true
  validates :m_annularis,       :presence => true
  validates :m_franksi,         :presence => true
  validates :m_faveolata,       :presence => true
end
