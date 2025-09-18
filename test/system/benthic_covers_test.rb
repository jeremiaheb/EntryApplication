require "application_system_test_case"

class BenthicCoversTest < ApplicationSystemTestCase
  test "new benthic cover" do
    boatlog_manager = FactoryBot.create(:boatlog_manager)
    diver = FactoryBot.create(:diver)
    buddy = FactoryBot.create(:diver)
    habitat_type = FactoryBot.create(:habitat_type, region: "Caribbean")
    cover_cat1 = FactoryBot.create(:cover_cat)
    cover_cat2 = FactoryBot.create(:cover_cat)

    visit root_url
    find(".benthic-covers-link").click
    login_as_diver(diver)
    find(".new-sample-button").click

    # TODO: If reuse is desired, extract this complex input to a function
    find("select#benthic_cover_boatlog_manager_id").select(boatlog_manager.agency_name)
    find("select#benthic_cover_diver_id").select(diver.diver_name)
    find("select#benthic_cover_buddy_id").select(buddy.diver_name)
    find("input#benthic_cover_field_id").fill_in(with: "30591A")
    find("input#benthic_cover_sample_date").fill_in(with: "2025-01-17")
    find("body").click # blur for calendar popup
    find("input#benthic_cover_sample_begin_time").fill_in(with: "10:30")
    find("select#benthic_cover_habitat_type_id").select(habitat_type.habitat_name)
    find("input#benthic_cover_meters_completed").fill_in(with: "15")
    find("textarea#benthic_cover_sample_description").fill_in(with: "Hello World")

    select2_choose(all("select[id$='cover_cat_id']", visible: nil).first, option: cover_cat1.display_name)
    all("input[id$='hardbottom_num']").first.fill_in(with: "15")
    all("input[id$='softbottom_num']").first.fill_in(with: "25")
    all("input[id$='rubble_num']").first.fill_in(with: "5")

    find("a.add_nested_fields[data-association=point_intercepts]").click # Add Cover
    select2_choose(all("select[id$='cover_cat_id']", visible: nil).last, option: cover_cat2.display_name)
    all("input[id$='hardbottom_num']").last.fill_in(with: "30")
    all("input[id$='softbottom_num']").last.fill_in(with: "14")
    all("input[id$='rubble_num']").last.fill_in(with: "11")
    find("body").click # blur for calculation
    assert_css ".coverTotal", text: "Total Points 100"

    find("input#benthic_cover_rugosity_measure_attributes_min_depth").fill_in(with: "5")
    find("input#benthic_cover_rugosity_measure_attributes_max_depth").fill_in(with: "5")
    find("input#benthic_cover_rugosity_measure_attributes_rug_meters_completed").fill_in(with: "15")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_1").fill_in(with: "1")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_2").fill_in(with: "2")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_3").fill_in(with: "3")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_4").fill_in(with: "4")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_5").fill_in(with: "5")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_6").fill_in(with: "6")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_7").fill_in(with: "7")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_8").fill_in(with: "8")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_9").fill_in(with: "9")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_10").fill_in(with: "10")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_11").fill_in(with: "11")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_12").fill_in(with: "12")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_13").fill_in(with: "13")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_14").fill_in(with: "14")
    find("input#benthic_cover_rugosity_measure_attributes_meter_mark_15").fill_in(with: "15")
    find("body").click # trigger validation
    assert_equal "120", find("input#RugosityTotalDisplay").value

    find("input#benthic_cover_invert_belt_attributes_lobster_num").fill_in(with: "1")
    find("input#benthic_cover_invert_belt_attributes_conch_num").fill_in(with: "2")
    find("input#benthic_cover_invert_belt_attributes_diadema_num").fill_in(with: "3")

    find("select#benthic_cover_presence_belt_attributes_a_cervicornis").select("Absent")
    find("select#benthic_cover_presence_belt_attributes_a_palmata").select("Present_Transect")
    find("select#benthic_cover_presence_belt_attributes_d_cylindrus").select("Present_Site")
    find("select#benthic_cover_presence_belt_attributes_m_annularis").select("Did Not Look")
    find("select#benthic_cover_presence_belt_attributes_m_faveolata").select("Absent")
    find("select#benthic_cover_presence_belt_attributes_m_franksi").select("Present_Transect")
    find("select#benthic_cover_presence_belt_attributes_m_ferox").select("Present_Site")

    find("body").click
    find("input[type=submit]").click

    assert_selector(".usa-alert", text: "Benthic cover was successfully created")

    assert_equal 1, BenthicCover.count

    benthic_cover = BenthicCover.first
    assert_equal 2, benthic_cover.point_intercepts.count
    assert_equal 45, benthic_cover.point_intercepts[0].cover_total
    assert_equal 55, benthic_cover.point_intercepts[1].cover_total
    assert_equal 120, benthic_cover.rugosity_measure.category_sum
  end
end
