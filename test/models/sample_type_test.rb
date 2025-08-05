require "test_helper"

class SampleTypeTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    sample_type = FactoryBot.create(:sample_type)
    assert sample_type.valid?
  end

  [:sample_type_name, :sample_type_description].each do |attribute|
    test "requires a #{attribute}" do
      sample_type = FactoryBot.build(:sample_type, attribute => "")
      assert_not sample_type.valid?
      assert_not_nil sample_type.errors[attribute]
    end
  end

  test "does not allow destruction if a sample exists referencing the sample type" do
    sample_type = FactoryBot.create(:sample_type)
    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, sample_type: sample_type, sample_animals: [sample_animal])

    refute sample_type.destroy
    assert_not_nil sample_type.errors[:base]

    # Once all the samples are gone, though, it can be deleted
    assert sample.destroy
    assert sample_type.destroy
  end
end
