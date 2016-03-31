class HabitatType < ActiveRecord::Base
  attr_protected []
  has_many :samples
  has_many :benthic_covers

  scope       :atlantic_habitats,      lambda { where(:region => "Atlantic") }
  
  validates :habitat_name, :presence => true
  validates :habitat_description, :presence => true
  validates :region, :presence => true

end
