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

  # TODO: Better understand what divers_responsible_for is doing. For now, these
  # tests are copied more or less directly from their original spec file.
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

  test "#benthic_covers_for_diver returns benthic covers scoped to a given diver" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    diver = FactoryBot.create(:diver)
    benthic_covers_for_diver = FactoryBot.create_list(:benthic_cover, 2, boatlog_manager: boatlog_manager, diver: diver)
    other_benthic_covers = [
      FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager),
      FactoryBot.create(:benthic_cover, diver: diver),
      FactoryBot.create(:benthic_cover),
    ]

    assert_equal benthic_covers_for_diver.sort, boatlog_manager.benthic_covers_for_diver(diver)
  end

  test "#coral_demographics_for_diver returns coral demographics scoped to a given diver" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    diver = FactoryBot.create(:diver)
    coral_demographics_for_diver = FactoryBot.create_list(:coral_demographic, 2, boatlog_manager: boatlog_manager, diver: diver)
    other_coral_demographics = [
      FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager),
      FactoryBot.create(:coral_demographic, diver: diver),
      FactoryBot.create(:coral_demographic),
    ]

    assert_equal coral_demographics_for_diver.sort, boatlog_manager.coral_demographics_for_diver(diver)
  end

  test "#samples_for_diver returns samples scoped to a given primary diver" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    diver = FactoryBot.create(:diver)

    sample_where_diver_is_primary = FactoryBot.create(:sample, diver: diver, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    sample_where_diver_is_not_primary = FactoryBot.create(:sample, buddy: diver, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    sample_with_other_diver = FactoryBot.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    assert_equal [sample_where_diver_is_primary], boatlog_manager.samples_for_diver(diver)
  end
end
