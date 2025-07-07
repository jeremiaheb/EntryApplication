require "test_helper"

class BoatLogTest < ActiveSupport::TestCase
  test "factory creates a valid instance" do
    boat_log = FactoryGirl.create(:boat_log)
    assert boat_log.valid?
  end

  test "#boatlog_divers returns a list of all the divers in the boat log" do
    rep_logs1 = FactoryGirl.create_list(:rep_log, 3)
    station_log1 = FactoryGirl.create(:station_log, stn_number: 1, rep_logs: rep_logs1)
    rep_logs2 = FactoryGirl.create_list(:rep_log, 2)
    station_log2 = FactoryGirl.create(:station_log, stn_number: 2, rep_logs: rep_logs2)
    boat_log = FactoryGirl.create(:boat_log, station_logs: [station_log1, station_log2])

    assert_equal [
      [boat_log.date, rep_logs1[0].field_id, rep_logs1[0].diver.diver_name],
      [boat_log.date, rep_logs1[1].field_id, rep_logs1[1].diver.diver_name],
      [boat_log.date, rep_logs1[2].field_id, rep_logs1[2].diver.diver_name],
      [boat_log.date, rep_logs2[0].field_id, rep_logs2[0].diver.diver_name],
      [boat_log.date, rep_logs2[1].field_id, rep_logs2[1].diver.diver_name],
    ].sort, boat_log.boatlog_divers.sort
  end
end
