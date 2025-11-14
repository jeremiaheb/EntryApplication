require "test_helper"

class RegionTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    region = FactoryBot.create(:region)
    assert region.valid?
  end
end
