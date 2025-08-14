require "test_helper"

class DiverTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    diver = FactoryBot.create(:diver)
    assert diver.valid?
  end

  test "#diver_proofing_samples returns only the current diver's samples" do
    diver = FactoryBot.create(:diver)
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)

    # Diver is primary only on sample1
    sample1 = FactoryBot.create(:sample, diver: diver, sample_animals: [FactoryBot.create(:sample_animal, sample: nil)])
    sample2 = FactoryBot.create(:sample, buddy: diver, sample_animals: [FactoryBot.create(:sample_animal, sample: nil)])
    sample3 = FactoryBot.create(:sample, sample_animals: [FactoryBot.create(:sample_animal, sample: nil)])

    assert_equal [sample1], diver.diver_proofing_samples
  end

  test "#diver_proofing_benthic_cover returns a diver's benthic covers" do
    diver = FactoryBot.create(:diver)
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    benthic_cover1 = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: diver)
    benthic_cover2 = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: diver)
    benthic_cover3 = FactoryBot.create(:benthic_cover, diver: diver)
    benthic_cover4 = FactoryBot.create(:benthic_cover)

    assert_equal [benthic_cover1, benthic_cover2, benthic_cover3].sort, diver.diver_proofing_benthic_cover
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
