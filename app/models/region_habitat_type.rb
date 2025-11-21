class RegionHabitatType < ApplicationRecord
  belongs_to :region
  validates :region_id, uniqueness: { scope: [:habitat_type_id] }

  belongs_to :habitat_type
end
