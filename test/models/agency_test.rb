require "test_helper"

class AgencyTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    agency = FactoryBot.create(:agency)
    assert agency.valid?
  end
end
