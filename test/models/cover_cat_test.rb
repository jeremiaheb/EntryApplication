require "test_helper"

class CoverCatTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    cover_cat = FactoryBot.create(:cover_cat)
    assert cover_cat.valid?
  end

  test "requires a name" do
    cover_cat = FactoryBot.build(:cover_cat, name: "")
    assert_not cover_cat.valid?
    assert_not_nil cover_cat.errors[:name]
  end

  test "#display_name joins short_code code and proofing name" do
    cover_cat = FactoryBot.create(:cover_cat, code: "RHO CRUS", proofing_code: "CCA Crustose Coralline Algae", short_code: "CCA")
    assert_equal "CCA __ RHO CRUS __ CCA Crustose Coralline Algae", cover_cat.display_name
  end
end
