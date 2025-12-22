require "test_helper"

class DemographicCoralTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    demographic_coral = FactoryBot.create(:demographic_coral)
    assert demographic_coral.valid?
  end

  test "factory (juvenile) creates a valid instance" do
    demographic_coral = FactoryBot.create(:demographic_coral, :juvenile)
    assert demographic_coral.valid?
  end
end
