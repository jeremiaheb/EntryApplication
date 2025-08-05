require "test_helper"

class AnimalTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    animal = FactoryBot.create(:animal)
    assert animal.valid?
  end

  [:species_code, :scientific_name, :common_name, :max_size, :min_size, :max_number].each do |attribute|
    test "requires a #{attribute}" do
      animal = FactoryBot.build(:animal, attribute => "")
      assert_not animal.valid?
      assert_not_nil animal.errors[attribute]
    end
  end

  test "#spp_code_common joins species code and common name" do
    animal = FactoryBot.build(:animal, species_code: "MY_FISH", common_name: "A Fish")
    assert_equal "MY_FISH __ A Fish", animal.spp_code_common
  end

  test "does not allow destruction if a sample exists referencing the animal" do
    animal = FactoryBot.create(:animal)
    sample = FactoryBot.create(:sample, sample_animals: [FactoryBot.build(:sample_animal, animal: animal)])

    refute animal.destroy
    assert_not_nil animal.errors[:base]

    # Once all the samples are gone, though, it can be deleted
    assert sample.destroy
    assert animal.destroy
  end
end
