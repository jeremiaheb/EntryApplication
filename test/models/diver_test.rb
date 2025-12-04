require "test_helper"

class DiverTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    diver = FactoryBot.create(:diver)
    assert diver.valid?
  end

  test "password must not be the same as username" do
    diver = FactoryBot.build(:diver, username: "diver1234", password: "diver1234")
    assert_not diver.valid?
    assert_not_nil diver.errors[:password]

    diver.password = "somethingelse1234"
    assert diver.valid?
  end
end
