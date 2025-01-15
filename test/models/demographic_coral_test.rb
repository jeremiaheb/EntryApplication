require "test_helper"

class DemographicCoralTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    demographic_coral = FactoryGirl.create(:demographic_coral)
    assert demographic_coral.valid?
  end
end
