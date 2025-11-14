require "test_helper"

class MissionTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    mission = FactoryBot.create(:mission)
    assert mission.valid?
  end
end
