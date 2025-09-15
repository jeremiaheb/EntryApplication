require "test_helper"

class BoatlogManagerTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    assert boatlog_manager.valid?
  end

  [:agency, :firstname, :lastname].each do |attribute|
    test "requires a #{attribute}" do
      boatlog_manager = FactoryBot.build(:boatlog_manager, attribute => "")
      assert_not boatlog_manager.valid?
      assert_not_nil boatlog_manager.errors[attribute]
    end
  end

  test "#agency_name combines agency and last name" do
    boatlog_manager = FactoryBot.build(:boatlog_manager, agency: "FWC", lastname: "Johnson")
    assert_equal "FWC/Johnson", boatlog_manager.agency_name
  end

  test "#divers_responsible_for returns the correct list of divers" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    benthic_cover = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager)
    benthic_cover2 = FactoryBot.create(:benthic_cover)
    coral_demographic = FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager)
    coral_demographic2 = FactoryBot.create(:coral_demographic)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    assert_equal [coral_demographic.diver, benthic_cover.diver, sample.diver].sort, boatlog_manager.divers_responsible_for.sort
  end

  test "#divers_responsible_for returns a unique list of divers" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    benthic_cover = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager)
    benthic_cover2 = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: benthic_cover.diver)
    coral_demographic = FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager)
    coral_demographic2 = FactoryBot.create(:coral_demographic)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    assert_equal [coral_demographic.diver, benthic_cover.diver, sample.diver].sort, boatlog_manager.divers_responsible_for.sort
  end
end
