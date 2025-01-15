require "test_helper"

class CoverCatTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    cover_cat = FactoryGirl.create(:cover_cat)
    assert cover_cat.valid?
  end

  test "requires a name" do
    cover_cat = FactoryGirl.build(:cover_cat, name: "")
    assert_not cover_cat.valid?
    assert_not_nil cover_cat.errors[:name]
  end

  test "#cover_code_name joins code and common" do
    cover_cat = FactoryGirl.create(:cover_cat, code: "RHO CRUS", name: "Rhodophyta cru. spp", common: "CCA Crustose Coralline Algae")
    assert_equal "RHO CRUS __ CCA Crustose Coralline Algae", cover_cat.cover_code_name
  end
end
