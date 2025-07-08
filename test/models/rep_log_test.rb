require "test_helper"

class RepLogTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    rep_log = FactoryBot.create(:rep_log)
    assert rep_log.valid?
  end

  test "#field_id combines primary sample unit, station number and replicate" do
    boat_log = FactoryBot.create(:boat_log, primary_sample_unit: "1234")
    station_log = FactoryBot.create(:station_log, boat_log: boat_log, stn_number: "2")
    rep_log = FactoryBot.create(:rep_log, station_log: station_log, replicate: "J")

    assert_equal "12342J", rep_log.field_id
  end
end
