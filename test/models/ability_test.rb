require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "when an admin" do
    user = FactoryGirl.create(:diver, role: Diver::ADMIN)
    ability = Ability.new(user)

    assert ability.can?(:manage, :all)
  end

  test "when a manager" do
    user = FactoryGirl.create(:diver, role: Diver::MANAGER)
    ability = Ability.new(user)

    assert ability.can?(:manage, Sample)
    assert ability.can?(:manage, CoralDemographic)
    assert ability.can?(:manage, BenthicCover)
    assert ability.can?(:manage, BoatLog)
  end

  test "when a diver" do
    user = FactoryGirl.create(:diver, role: Diver::DIVER)
    ability = Ability.new(user)

    user_coral_demographic = FactoryGirl.create(:coral_demographic, diver: user)
    other_coral_demographic = FactoryGirl.create(:coral_demographic)

    assert ability.can?(:create, CoralDemographic)
    assert ability.can?(:read, user_coral_demographic)
    assert ability.can?(:destroy, CoralDemographic)
    assert ability.can?(:update, user_coral_demographic)
    assert_not ability.can?(:update, other_coral_demographic)
  end
end
