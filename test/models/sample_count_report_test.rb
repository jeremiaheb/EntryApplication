require "test_helper"

class SampleCountReportTest < ActiveSupport::TestCase
  test "counts boat logs, samples, benthic covers and coral demographics by diver" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    boatlog_manager = FactoryBot.create(:boatlog_manager)
    boat_log = FactoryBot.create(:boat_log, boatlog_manager: boatlog_manager)
    station_log = FactoryBot.create(:station_log, boat_log: boat_log)
    rep_log1 = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "A")
    rep_log2 = FactoryBot.create(:rep_log, station_log: station_log, diver: diver2, replicate: "B")

    sample_animal = FactoryBot.create(:sample_animal, sample: nil)
    sample = FactoryBot.create(:sample, boatlog_manager: boatlog_manager, diver: diver1, buddy: diver2, sample_animals: [sample_animal])
    benthic_cover = FactoryBot.create(:benthic_cover, boatlog_manager: boatlog_manager, diver: diver2, buddy: diver1)
    coral_demo = FactoryBot.create(:coral_demographic, boatlog_manager: boatlog_manager, diver: diver1, buddy: diver2)

    report = SampleCountReport.new([boatlog_manager])
    assert_equal({
      diver1 => { "boat" => 1, "sample" => 1, "lpi" => 0, "demo" => 1 },
      diver2 => { "boat" => 1, "sample" => 0, "lpi" => 1, "demo" => 0 },
    }, report.counts_by_diver)
  end
end
