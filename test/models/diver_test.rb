require "test_helper"

class DiverTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    diver = FactoryBot.create(:diver)
    assert diver.valid?
  end

  test "#diver_proofing_coral_demo returns a diver's coral demographics" do
    diver = FactoryBot.create(:diver)
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    coral_demographic1 = FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager, diver: diver)
    coral_demographic2 = FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager, diver: diver)
    coral_demographic3 = FactoryBot.create(:coral_demographic, diver: diver)
    coral_demographic4 = FactoryBot.create(:coral_demographic)

    assert_equal [coral_demographic1, coral_demographic2, coral_demographic3].sort, diver.diver_proofing_coral_demo
  end
end
