require "test_helper"

class CrosscheckReportTest < ActiveSupport::TestCase
  test "returns nothing when boat logs match samples" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    mission = FactoryBot.create(:mission)
    boat_log = FactoryBot.create(:boat_log, date: "2025-05-06", mission: mission, primary_sample_unit: "1234")
    station_log = FactoryBot.create(:station_log, stn_number: "1", boat_log: boat_log)
    rep_logA = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "A")
    rep_logB = FactoryBot.create(:rep_log, station_log: station_log, diver: diver2, replicate: "B")
    rep_logI = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "I")
    rep_logX = FactoryBot.create(:rep_log, station_log: station_log, diver: diver2, replicate: "X")

    sample_animalA = FactoryBot.create(:sample_animal, sample: nil)
    sampleA = FactoryBot.create(:sample, sample_date: "2025-05-06", field_id: "12341A", mission: mission, diver: diver1, buddy: diver2, sample_animals: [sample_animalA])
    sample_animalB = FactoryBot.create(:sample_animal, sample: nil)
    sampleB = FactoryBot.create(:sample, sample_date: "2025-05-06", field_id: "12341B", mission: mission, diver: diver2, buddy: diver1, sample_animals: [sample_animalB])
    benthic_coverI = FactoryBot.create(:benthic_cover, sample_date: "2025-05-06", field_id: "12341I", mission: mission, diver: diver1, buddy: diver2)
    coral_demoX = FactoryBot.create(:coral_demographic, sample_date: "2025-05-06", field_id: "12341X", mission: mission, diver: diver2, buddy: diver1)

    report = CrosscheckReport.new([mission])
    assert_equal [], report.missing_samples_from_diver
    assert_equal [], report.missing_samples_from_boat_log
  end

  test "identifies potentially missing boat logs" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    mission = FactoryBot.create(:mission)

    sample_animalA = FactoryBot.create(:sample_animal, sample: nil)
    sampleA = FactoryBot.create(:sample, sample_date: "2025-05-06", field_id: "12341A", mission: mission, diver: diver1, buddy: diver2, sample_animals: [sample_animalA])
    sample_animalB = FactoryBot.create(:sample_animal, sample: nil)
    sampleB = FactoryBot.create(:sample, sample_date: "2025-05-06", field_id: "12341B", mission: mission, diver: diver2, buddy: diver1, sample_animals: [sample_animalB])
    benthic_coverI = FactoryBot.create(:benthic_cover, sample_date: "2025-05-06", field_id: "12341I", mission: mission, diver: diver1, buddy: diver2)
    coral_demoX = FactoryBot.create(:coral_demographic, sample_date: "2025-05-06", field_id: "12341X", mission: mission, diver: diver2, buddy: diver1)

    report = CrosscheckReport.new([mission])
    assert_equal 0, report.missing_samples_from_diver.length
    assert_equal 4, report.missing_samples_from_boat_log.length
  end

  test "identifies potentially missing samples" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    mission = FactoryBot.create(:mission)
    boat_log = FactoryBot.create(:boat_log, date: "2025-05-06", mission: mission, primary_sample_unit: "1234")
    station_log = FactoryBot.create(:station_log, stn_number: "1", boat_log: boat_log)
    rep_logA = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "A")
    rep_logB = FactoryBot.create(:rep_log, station_log: station_log, diver: diver2, replicate: "B")
    rep_logI = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "I")
    rep_logX = FactoryBot.create(:rep_log, station_log: station_log, diver: diver2, replicate: "X")

    report = CrosscheckReport.new([mission])
    assert_equal 4, report.missing_samples_from_diver.length
    assert_equal 0, report.missing_samples_from_boat_log.length
  end

  test "identifies date mismatches for potentially missing boat logs" do
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)

    mission = FactoryBot.create(:mission)
    boat_log = FactoryBot.create(:boat_log, date: "2025-05-06", mission: mission, primary_sample_unit: "1234")
    station_log = FactoryBot.create(:station_log, stn_number: "1", boat_log: boat_log)
    rep_logA = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "A")

    # Sample would otherwise match up, but the date is wrong relative to the
    # boat log.
    sample_animalA = FactoryBot.create(:sample_animal, sample: nil)
    sampleA = FactoryBot.create(:sample, sample_date: "2025-05-07", field_id: "12341A", mission: mission, diver: diver1, buddy: diver2, sample_animals: [sample_animalA])

    report = CrosscheckReport.new([mission])
    assert_equal 1, report.missing_samples_from_diver.length
    assert_equal boat_log, report.missing_samples_from_diver[0].related_model
    assert_equal 1, report.missing_samples_from_boat_log.length
    assert_equal sampleA, report.missing_samples_from_boat_log[0].related_model
  end

  test "identifies boatlog manager ID mismatches for potentially mismatched entries" do
    # Sometimes a diver will log a sample under the incorrect boatlog manager
    diver1 = FactoryBot.create(:diver)
    diver2 = FactoryBot.create(:diver)
    mission1 = FactoryBot.create(:mission)
    mission2 = FactoryBot.create(:mission)

    boat_log = FactoryBot.create(:boat_log, date: "2025-05-06", mission: mission1, primary_sample_unit: "1234")
    station_log = FactoryBot.create(:station_log, stn_number: "1", boat_log: boat_log)
    rep_logA = FactoryBot.create(:rep_log, station_log: station_log, diver: diver1, replicate: "A")

    # Sample would otherwise match up, but the boatlog manager is incorrect
    sample_animalA = FactoryBot.create(:sample_animal, sample: nil)
    sampleA = FactoryBot.create(:sample, sample_date: "2025-05-06", field_id: "12341A", mission: mission2, diver: diver1, buddy: diver2, sample_animals: [sample_animalA])

    report = CrosscheckReport.new([mission1, mission2])
    assert_equal 1, report.missing_samples_from_diver.length
    assert_equal boat_log, report.missing_samples_from_diver[0].related_model
    assert_equal 1, report.missing_samples_from_boat_log.length
    assert_equal sampleA, report.missing_samples_from_boat_log[0].related_model
  end
end
