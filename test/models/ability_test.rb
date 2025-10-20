require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "when an admin" do
    user = FactoryBot.create(:diver, role: Diver::ADMIN)
    ability = Ability.new(user)

    assert ability.can?(:manage, :all)
  end

  test "when a manager" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    user = FactoryBot.create(:diver, role: Diver::MANAGER, boatlog_manager: boatlog_manager)
    ability = Ability.new(user)

    user_benthic_cover = FactoryBot.create(:benthic_cover, diver: user)
    boatlog_manager_benthic_cover = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager)
    other_benthic_cover = FactoryBot.create(:benthic_cover)

    assert ability.can?(:create, BenthicCover)
    assert ability.can?(:manage, user_benthic_cover)
    assert ability.can?(:manage, boatlog_manager_benthic_cover)
    assert_not ability.can?(:manage, other_benthic_cover)

    user_boat_log = FactoryBot.create(:boat_log, boatlog_manager: boatlog_manager)
    other_boat_log = FactoryBot.create(:boat_log)

    assert ability.can?(:create, BoatLog)
    assert ability.can?(:manage, user_boat_log)
    assert_not ability.can?(:manage, other_boat_log)
  end

  test "when a diver" do
    user = FactoryBot.create(:diver, role: Diver::DIVER)
    ability = Ability.new(user)

    user_coral_demographic = FactoryBot.create(:coral_demographic, diver: user)
    other_coral_demographic = FactoryBot.create(:coral_demographic)

    assert ability.can?(:create, CoralDemographic)
    assert ability.can?(:draft, CoralDemographic)
    assert ability.can?(:read, user_coral_demographic)
    assert ability.can?(:update, user_coral_demographic)
    assert_not ability.can?(:update, other_coral_demographic)
    assert_not ability.can?(:destroy, other_coral_demographic)
  end
end
