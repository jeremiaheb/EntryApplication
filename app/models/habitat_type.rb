class HabitatType < ActiveRecord::Base
  attr_protected []
  has_many :samples
  has_many :benthic_covers

  validates :habitat_name, :presence => true
  validates :habitat_description, :presence => true

end
