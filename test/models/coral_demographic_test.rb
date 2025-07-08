require "test_helper"

class CoralDemographicTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    coral_demographic = FactoryBot.create(:coral_demographic)
    assert coral_demographic.valid?
  end
end
