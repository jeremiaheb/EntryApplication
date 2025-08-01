class HabitatType < ActiveRecord::Base
  has_many :samples
  has_many :benthic_covers

  scope       :atlantic_habitats,           lambda { where(region: "Atlantic") }
  scope       :caribbean_habitats,          lambda { where(region: "Caribbean") }
  scope       :flowergardens_habitats,      lambda { where(region: "FlowerGardens") }

  validates :habitat_name, presence: true
  validates :habitat_description, presence: true
  validates :region, presence: true
end
