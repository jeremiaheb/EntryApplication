require "application_system_test_case"

class BoatLogsTest < ApplicationSystemTestCase
  test "new boat log" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    manager_diver = FactoryBot.create(:diver, role: "manager")
    fish_diver1 = FactoryBot.create(:diver)
    fish_diver2 = FactoryBot.create(:diver)
    demo_diver1 = FactoryBot.create(:diver)
    lpi_diver1 = FactoryBot.create(:diver)

    visit root_url
    find(".login-link").click
    login_as_diver(manager_diver)
    find(".boat-logs-link").click
    find(".new-boat-log-button").click

    find("select#boat_log_boatlog_manager_id").select(boatlog_manager.agency_name)
    find("input#boat_log_primary_sample_unit").fill_in(with: "4000")

    all("input[id$='stn_number']").first.fill_in(with: "1")
    all("input[id$='time']").first.fill_in(with: "10:55")
    all("input[id$='latitude_in_northern_degrees']").first.fill_in(with: "17.8082755")
    all("input[id$='longitude_in_western_degrees']").first.fill_in(with: "64.63745367")

    all("input[id$='replicate']")[0].fill_in(with: "A")
    all("select[id$='diver_id']")[0].select(fish_diver1.diver_name)
    assert_equal "Fish Diver", all("label.diver_type_label")[0].text

    all("input[id$='replicate']")[1].fill_in(with: "B")
    all("select[id$='diver_id']")[1].select(fish_diver2.diver_name)
    assert_equal "Fish Diver", all("label.diver_type_label")[1].text

    find("a.add_nested_fields[data-association='rep_logs']").click # Add Replicate
    all("input[id$='replicate']")[2].fill_in(with: "X")
    all("select[id$='diver_id']")[2].select(demo_diver1.diver_name)
    assert_equal "Demo Diver", all("label.diver_type_label")[2].text

    find("a.add_nested_fields[data-association='rep_logs']").click # Add Replicate
    all("input[id$='replicate']")[3].fill_in(with: "J")
    all("select[id$='diver_id']")[3].select(lpi_diver1.diver_name)
    assert_equal "LPI Diver", all("label.diver_type_label")[3].text

    all("textarea[id$='comments']").first.fill_in(with: "Hello World")

    find("body").click
    find("input[type=submit]").click

    assert_selector ".alert", text: "Boat log was successfully created"

    assert_equal 1, BoatLog.count

    boat_log = BoatLog.first
    assert_equal boatlog_manager, boat_log.boatlog_manager
    assert_equal "4000", boat_log.primary_sample_unit

    assert_equal 1, boat_log.station_logs.count
    station_log_1 = boat_log.station_logs.first
    assert_equal 1, station_log_1.stn_number
    assert_equal "10:55", station_log_1.time.strftime("%H:%M")
    assert_equal "Hello World", station_log_1.comments

    rep_logs = boat_log.rep_logs.order(:id)
    assert_equal 4, rep_logs.count
    assert_equal "A", rep_logs[0].replicate
    assert_equal fish_diver1, rep_logs[0].diver
    assert_equal "B", rep_logs[1].replicate
    assert_equal fish_diver2, rep_logs[1].diver
    assert_equal "X", rep_logs[2].replicate
    assert_equal demo_diver1, rep_logs[2].diver
    assert_equal "J", rep_logs[3].replicate
    assert_equal lpi_diver1, rep_logs[3].diver
  end
end