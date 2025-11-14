class MissionManager < ApplicationRecord
  belongs_to :mission
  validates :mission_id, uniqueness: { scope: [:diver_id] }

  belongs_to :diver
end
