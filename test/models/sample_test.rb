require "test_helper"

class SampleTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, sample_animals: [sample_animal])

    assert sample.valid?
  end

  test "#field_id is upcased automatically" do
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, sample_animals: [sample_animal])

    assert_equal "10011A", sample.field_id
  end

  test "#myId returns diver ID" do
    diver = FactoryBot.create(:diver)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, sample_animals: [sample_animal])
    diver_sample = FactoryBot.create(:diver_sample, sample: sample, diver: diver, primary_diver: true)

    assert_equal sample.diver.id, sample.myId
  end

  test "#msn is correct" do
    diver = FactoryBot.create(:diver)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(
      :sample,
      sample_date: Date.parse("2022-05-06"),
      sample_begin_time: Time.parse("2022-05-06T09:10:11Z"),
      sample_animals: [sample_animal],
    )
    diver_sample = FactoryBot.create(:diver_sample, sample: sample, diver: diver, primary_diver: true)

    assert_equal "A202205060910#{sample.diver.diver_number}", sample.msn
  end

  test "associating a sample with a diver" do
    diver = FactoryBot.create(:diver)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, sample_animals: [sample_animal])
    diver_sample = FactoryBot.create(:diver_sample, sample: sample, diver: diver, primary_diver: true)

    assert_equal diver, sample.diver
  end
end
