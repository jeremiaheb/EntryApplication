require "test_helper"

class BoatlogManagerTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    assert boatlog_manager.valid?
  end

  [:agency, :firstname, :lastname].each do |attribute|
    test "requires a #{attribute}" do
      boatlog_manager = FactoryGirl.build(:boatlog_manager, attribute => "")
      assert_not boatlog_manager.valid?
      assert_not_nil boatlog_manager.errors[attribute]
    end
  end

  test "#agency_name combines agency and last name" do
    boatlog_manager = FactoryGirl.build(:boatlog_manager, agency: "FWC", lastname: "Johnson")
    assert_equal "FWC/Johnson", boatlog_manager.agency_name
  end

  # TODO: Better understand what divers_responsible_for is doing. For now, these
  # tests are copied more or less directly from their original spec file.
  test "#divers_responsible_for returns the correct list of divers" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    benthic_cover = FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager)
    benthic_cover2 = FactoryGirl.create(:benthic_cover)
    coral_demographic = FactoryGirl.create(:coral_demographic, boatlog_manager: boatlog_manager)
    coral_demographic2 = FactoryGirl.create(:coral_demographic)
    sample_animal = FactoryGirl.create(:sample_animal, sample: nil)
    sample = FactoryGirl.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])
    diver_sample = FactoryGirl.create(:diver_sample, sample: sample)
    diver_sample2 = FactoryGirl.create(:diver_sample, sample: nil)

    assert_equal [coral_demographic.diver, benthic_cover.diver, diver_sample.diver].sort, boatlog_manager.divers_responsible_for.sort
  end

  test "#divers_responsible_for returns a unique list of divers" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    benthic_cover = FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager)
    benthic_cover2 = FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: benthic_cover.diver)
    coral_demographic = FactoryGirl.create(:coral_demographic, boatlog_manager: boatlog_manager)
    coral_demographic2 = FactoryGirl.create(:coral_demographic)
    sample_animal = FactoryGirl.create(:sample_animal, sample: nil)
    sample = FactoryGirl.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])
    diver_sample = FactoryGirl.create(:diver_sample, sample: sample)
    diver_sample2 = FactoryGirl.create(:diver_sample, sample: nil)

    assert_equal [coral_demographic.diver, benthic_cover.diver, diver_sample.diver].sort, boatlog_manager.divers_responsible_for.sort
  end

  test "#benthic_covers_for_diver returns benthic covers scoped to a given diver" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    diver = FactoryGirl.create(:diver)
    benthic_covers_for_diver = FactoryGirl.create_list(:benthic_cover, 2, boatlog_manager: boatlog_manager, diver: diver)
    other_benthic_covers = [
      FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager),
      FactoryGirl.create(:benthic_cover, diver: diver),
      FactoryGirl.create(:benthic_cover)
    ]

    assert_equal benthic_covers_for_diver.sort, boatlog_manager.benthic_covers_for_diver(diver)
  end

  test "#coral_demographics_for_diver returns coral demographics scoped to a given diver" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    diver = FactoryGirl.create(:diver)
    coral_demographics_for_diver = FactoryGirl.create_list(:coral_demographic, 2, boatlog_manager: boatlog_manager, diver: diver)
    other_coral_demographics = [
      FactoryGirl.create(:coral_demographic, boatlog_manager: boatlog_manager),
      FactoryGirl.create(:coral_demographic, diver: diver),
      FactoryGirl.create(:coral_demographic)
    ]

    assert_equal coral_demographics_for_diver.sort, boatlog_manager.coral_demographics_for_diver(diver)
  end

  test "#samples_for_diver returns samples scoped to a given primary diver" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    sample_animal = FactoryGirl.create(:sample_animal, sample: nil)
    diver = FactoryGirl.create(:diver)

    sample_where_diver_is_primary = FactoryGirl.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])
    FactoryGirl.create(:diver_sample, diver: diver, primary_diver: true, sample: sample_where_diver_is_primary)

    sample_where_diver_is_not_primary = FactoryGirl.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])
    FactoryGirl.create(:diver_sample, diver: diver, primary_diver: false, sample: sample_where_diver_is_primary)

    sample_with_other_diver = FactoryGirl.create(:sample, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])
    FactoryGirl.create(:diver_sample, primary_diver: true, sample: sample_with_other_diver)

    assert_equal [sample_where_diver_is_primary], boatlog_manager.samples_for_diver(diver)
  end
end
