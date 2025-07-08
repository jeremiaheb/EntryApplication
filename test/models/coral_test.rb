require "test_helper"

class CoralTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    coral = FactoryBot.create(:coral)
    assert coral.valid?
  end

  test "requires a code" do
    coral = FactoryBot.build(:coral, code: "")
    assert_not coral.valid?
    assert_not_nil coral.errors[:code]
  end

  test "requires a scientific name" do
    coral = FactoryBot.build(:coral, scientific_name: "")
    assert_not coral.valid?
    assert_not_nil coral.errors[:scientific_name]
  end
end
