require "application_system_test_case"

class CoralDemographicsTest < ApplicationSystemTestCase
  test "new coral demographic" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    diver = FactoryBot.create(:diver)
    buddy = FactoryBot.create(:diver)
    habitat_type = FactoryBot.create(:habitat_type, region: "Caribbean")
    coral1 = FactoryBot.create(:coral)
    coral2 = FactoryBot.create(:coral)

    visit root_url
    find(".coral-demographics-link").click

    find("input#diver_username").fill_in(with: diver.username)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    find("#newSampleButton").click

    # TODO: If reuse is desired, extract this complex input to a function
    find("select#coral_demographic_boatlog_manager_id").select(boatlog_manager.agency_name)
    find("select#coral_demographic_diver_id").select(diver.diver_name)
    find("select#coral_demographic_buddy").select(buddy.diver_name)
    find("input#coral_demographic_field_id").fill_in(with: "30591A")
    find("input#coral_demographic_sample_date").fill_in(with: "2025-01-17")
    find("body").click # blur for calendar popup
    find("input#coral_demographic_sample_begin_time").fill_in(with: "10:30")
    find("select#coral_demographic_habitat_type_id").select(habitat_type.habitat_name)
    find("input#coral_demographic_meters_completed").fill_in(with: "10")
    find("input#coral_demographic_percent_hardbottom").fill_in(with: "50")
    find("textarea#coral_demographic_sample_description").fill_in(with: "Hello World")

    all("input#meter_mark").first.fill_in(with: "1")
    select2_choose(all("select[id$='coral_id']", visible: nil).first, option: coral1.coral_code_name)
    all("input[id$='max_diameter']").first.fill_in(with: "4")
    all("input[id$='perpendicular_diameter']").first.fill_in(with: "3")
    all("input[id$='height']").first.fill_in(with: "20")
    all("input[id$='old_mortality']").first.fill_in(with: "5")
    all("input[id$='recent_mortality']").first.fill_in(with: "1")
    all("select[id$='bleach_condition']").first.select("None")
    all("select[id$='disease']").first.select("Absent")

    find("a.add_nested_fields[data-association=demographic_corals]").click # "Add Coral"
    all("input#meter_mark").last.fill_in(with: "2")
    select2_choose(all("select[id$='coral_id']", visible: nil).last, option: coral2.coral_code_name)
    all("input[id$='max_diameter']").last.fill_in(with: "6")
    all("input[id$='perpendicular_diameter']").last.fill_in(with: "5")
    all("input[id$='height']").last.fill_in(with: "25")
    all("input[id$='old_mortality']").last.fill_in(with: "3")
    all("input[id$='recent_mortality']").last.fill_in(with: "2")
    all("select[id$='bleach_condition']").last.select("Total")
    all("select[id$='disease']").last.select("Fast")

    find("body").click
    find("input[type=submit]").click

    assert_selector(".alert", text: "Coral demographic was successfully created")

    assert_equal 1, CoralDemographic.count

    coral_demographic = CoralDemographic.first
    assert_equal 2, coral_demographic.demographic_corals.count
    assert_equal coral1, coral_demographic.demographic_corals[0].coral
    assert_equal coral2, coral_demographic.demographic_corals[1].coral
  end
end
