require "test_helper"

class DiverTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    diver = FactoryGirl.create(:diver)
    assert diver.valid?
  end

  test "#whole_name" do
    diver = FactoryGirl.create(:diver, firstname: "Jeremiah", lastname: "Blondeau")
    assert_equal "Jeremiah Blondeau", diver.whole_name
  end

  test "#diver_proofing_samples returns only the current diver's samples" do
    diver = FactoryGirl.create(:diver)
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    sample_animal = FactoryGirl.create(:sample_animal, sample: nil)
    samples = FactoryGirl.create_list(:sample, 3, boatlog_manager: boatlog_manager, sample_animals: [sample_animal])

    # Diver will be primary on first, secondary on second and neither on the third
    diver_sample0 = FactoryGirl.create(:diver_sample, diver: diver, sample: samples[0], primary_diver: true)
    diver_sample1 = FactoryGirl.create(:diver_sample, diver: diver, sample: samples[1], primary_diver: false)
    diver_sample2 = FactoryGirl.create(:diver_sample, sample: samples[2], primary_diver: true)

    assert_equal [diver_sample0], diver.diver_proofing_samples
  end

  test "#diver_proofing_benthic_cover returns a diver's benthic covers" do
    diver = FactoryGirl.create(:diver)
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    benthic_cover1 = FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: diver)
    benthic_cover2 = FactoryGirl.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: diver)
    benthic_cover3 = FactoryGirl.create(:benthic_cover, diver: diver)
    benthic_cover4 = FactoryGirl.create(:benthic_cover)

    assert_equal [benthic_cover1, benthic_cover2, benthic_cover3].sort, diver.diver_proofing_benthic_cover
  end

  test "#diver_proofing_coral_demo returns a diver's coral demographics" do
    diver = FactoryGirl.create(:diver)
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    coral_demographic1 = FactoryGirl.create(:coral_demographic, boatlog_manager: boatlog_manager, diver: diver)
    coral_demographic2 = FactoryGirl.create(:coral_demographic, boatlog_manager: boatlog_manager, diver: diver)
    coral_demographic3 = FactoryGirl.create(:coral_demographic, diver: diver)
    coral_demographic4 = FactoryGirl.create(:coral_demographic)

    assert_equal [coral_demographic1, coral_demographic2, coral_demographic3].sort, diver.diver_proofing_coral_demo
  end
end
