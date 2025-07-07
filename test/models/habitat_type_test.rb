require "test_helper"

class HabitatTypeTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    habitat_type = FactoryGirl.create(:habitat_type)
    assert habitat_type.valid?
  end

  [:habitat_name, :habitat_description].each do |attribute|
    test "requires a #{attribute}" do
      habitat_type = FactoryGirl.build(:habitat_type, attribute => "")
      assert_not habitat_type.valid?
      assert_not_nil habitat_type.errors[attribute]
    end
  end
end
