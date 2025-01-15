require "test_helper"

class RugosityMeasureTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    rugosity_measure = FactoryGirl.create(:rugosity_measure)
    assert rugosity_measure.valid?
  end

  test "#category_sum is the sum of all meter marks" do
    rugosity_measure = FactoryGirl.create(
      :rugosity_measure,
      rug_meters_completed: 15,
      meter_mark_1: 1,
      meter_mark_2: 2,
      meter_mark_3: 3,
      meter_mark_4: 4,
      meter_mark_5: 5,
      meter_mark_6: 6,
      meter_mark_7: 7,
      meter_mark_8: 8,
      meter_mark_9: 9,
      meter_mark_10: 10,
      meter_mark_11: 11,
      meter_mark_12: 12,
      meter_mark_13: 13,
      meter_mark_14: 14,
      meter_mark_15: 15,
    )

    assert_equal 120, rugosity_measure.category_sum
  end
end
