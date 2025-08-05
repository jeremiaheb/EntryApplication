class HabitatType < ActiveRecord::Base
  VALID_REGIONS = [
    "Atlantic",
    "Caribbean",
    "FlowerGardens",
  ]

  has_many :samples, dependent: :restrict_with_error
  has_many :benthic_covers, dependent: :restrict_with_error

  scope       :atlantic_habitats,           lambda { where(region: "Atlantic") }
  scope       :caribbean_habitats,          lambda { where(region: "Caribbean") }
  scope       :flowergardens_habitats,      lambda { where(region: "FlowerGardens") }

  validates :habitat_name, presence: true
  validates :habitat_description, presence: true
  validates :region, presence: true, inclusion: VALID_REGIONS
end
