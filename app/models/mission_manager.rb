class MissionManager < ActiveRecord::Base
  belongs_to :mission
  validates :mission_id, uniqueness: { scope: [:manager_id] }

  belongs_to :manager, class_name: "Diver"
end
