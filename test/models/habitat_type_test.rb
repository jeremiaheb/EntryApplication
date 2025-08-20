require "test_helper"

class HabitatTypeTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    habitat_type = FactoryBot.create(:habitat_type)
    assert habitat_type.valid?
  end

  [:habitat_name, :habitat_description].each do |attribute|
    test "requires a #{attribute}" do
      habitat_type = FactoryBot.build(:habitat_type, attribute => "")
      assert_not habitat_type.valid?
      assert_not_nil habitat_type.errors[attribute]
    end
  end

  test "requires a valid region" do
    habitat_type = FactoryBot.build(:habitat_type, region: "bogus")
    assert_not habitat_type.valid?
    assert_not_nil habitat_type.errors[:region]
  end
end
