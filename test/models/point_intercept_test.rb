require "test_helper"

class PointInterceptTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    point_intercept = FactoryBot.create(:point_intercept)
    assert point_intercept.valid?
  end

  test "#cover_total sums hard bottom, soft bottom and rubble" do
    point_intercept = FactoryBot.build(:point_intercept, hardbottom_num: 25, softbottom_num: 50)
    assert_equal 75, point_intercept.cover_total

    point_intercept.rubble_num = 10
    assert_equal 85, point_intercept.cover_total
  end
end
