require "test_helper"

class DiverTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    diver = FactoryBot.create(:diver)
    assert diver.valid?
  end
end
