class JurisdictionHabitatType < ActiveRecord::Base
  belongs_to :jurisdiction
  validates :jurisdiction_id, uniqueness: { scope: [:habitat_type_id] }

  belongs_to :habitat_type
end
