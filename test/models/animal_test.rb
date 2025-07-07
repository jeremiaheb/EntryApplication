require "test_helper"

class AnimalTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    animal = FactoryGirl.create(:animal)
    assert animal.valid?
  end

  [:species_code, :scientific_name, :common_name, :max_size, :min_size, :max_number].each do |attribute|
    test "requires a #{attribute}" do
      animal = FactoryGirl.build(:animal, attribute => "")
      assert_not animal.valid?
      assert_not_nil animal.errors[attribute]
    end
  end

  test "#spp_code_common joins species code and common name" do
    animal = FactoryGirl.build(:animal, species_code: "MY_FISH", common_name: "A Fish")
    assert_equal "MY_FISH __ A Fish", animal.spp_code_common
  end
end
