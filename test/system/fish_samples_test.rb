require "application_system_test_case"

class FishSamplesTest < ApplicationSystemTestCase
  test "new fish sample" do
    boatlog_manager = FactoryGirl.create(:boatlog_manager)
    diver = FactoryGirl.create(:diver)
    buddy = FactoryGirl.create(:diver)
    sample_type = FactoryGirl.create(:sample_type)
    habitat_type = FactoryGirl.create(:habitat_type, region: "Caribbean")
    animal1 = FactoryGirl.create(:animal, common_name: "Fish 1")
    animal2 = FactoryGirl.create(:animal, common_name: "Fish 2")

    visit root_url
    find(".samples-link").click

    find("input#diver_username").fill_in(with: diver.username)
    find("input#diver_password").fill_in(with: diver.password)
    find("input[type=submit]").click

    find("#newSampleButton").click

    # TODO: If reuse is desired, extract this complex input to a function
    #
    # Samples, Sample Section
    find("select#sample_boatlog_manager_id").select(boatlog_manager.agency_name)
    find("select#sample_diver_samples_attributes_0_diver_id").select(diver.diver_name)
    find("select#sample_diver_samples_attributes_1_diver_id").select(buddy.diver_name)
    find("select#sample_sample_type_id").select(sample_type.sample_type_name)
    find("select#sample_habitat_type_id").select(habitat_type.habitat_name)
    find("input#sample_dive_begin_time").fill_in(with: "10:00")
    find("input#sample_dive_end_time").fill_in(with: "10:30")
    find("input#sample_sample_begin_time").fill_in(with: "10:10")
    find("input#sample_sample_end_time").fill_in(with: "10:25")
    find("input#sample_field_id").fill_in(with: "30591A")
    find("input#sample_dive_depth").fill_in(with: "75")
    find("input#sample_sample_depth").fill_in(with: "73")
    find("input#sample_underwater_visibility").fill_in(with: "9")
    find("input#sample_water_temp").fill_in(with: "86.0")
    find("select#sample_current").select("Moderate")
    find("select#sample_fishing_gear").select("None")
    find("textarea#sample_sample_description").fill_in(with: "Hello World")
    find("button#gotoSubstrate").click
    # Samples, Substrate Section
    find("input#sample_substrate_max_depth").fill_in(with: "75")
    find("input#sample_substrate_min_depth").fill_in(with: "74")
    find("input#sample_hard_verticle_relief").fill_in(with: "0.65")
    find("input#sample_soft_verticle_relief").fill_in(with: "0.35")
    find("input#sample_hard_relief_cat_0").fill_in(with: "55")
    find("input#sample_soft_relief_cat_0").fill_in(with: "85")
    find("input#sample_hard_relief_cat_1").fill_in(with: "30")
    find("input#sample_soft_relief_cat_1").fill_in(with: "15")
    find("input#sample_hard_relief_cat_2").fill_in(with: "15")
    find("body").click # trigger validation
    assert_equal "100", find("input#hard_relief_total").value
    find("input#sample_sand_percentage").fill_in(with: "30")
    find("input#sample_hardbottom_percentage").fill_in(with: "50")
    find("input#sample_rubble_percentage").fill_in(with: "20")
    find("body").click # trigger validation
    assert_equal "100", find("input#abiotic_percentage_total").value
    find("input#sample_sand_bare").fill_in(with: "5")
    find("input#sample_sand_macro_algae").fill_in(with: "10")
    find("input#sample_sand_seagrass").fill_in(with: "15")
    find("input#sample_sand_sponge").fill_in(with: "20")
    find("input#sample_sand_pcov_other1_lab").fill_in(with: "sandother1")
    find("input#sample_sand_pcov_other1").fill_in(with: "22")
    find("input#sample_sand_pcov_other2_lab").fill_in(with: "sandother2")
    find("input#sample_sand_pcov_other2").fill_in(with: "28")
    find("body").click # trigger validation
    assert_equal "100", find("input#biotic_percentage_sand_total").value
    find("input#sample_hardbottom_algal_turf").fill_in(with: "7")
    find("input#sample_hardbottom_macro_algae").fill_in(with: "13")
    find("input#sample_hardbottom_live_coral").fill_in(with: "12")
    find("input#sample_hardbottom_octocoral").fill_in(with: "18")
    find("input#sample_hardbottom_sponge").fill_in(with: "10")
    find("input#sample_hard_pcov_other1_lab").fill_in(with: "hardbottomother1")
    find("input#sample_hard_pcov_other1").fill_in(with: "11")
    find("input#sample_hard_pcov_other2_lab").fill_in(with: "hardbottomother2")
    find("input#sample_hard_pcov_other2").fill_in(with: "29")
    find("body").click # trigger validation
    assert_equal "100", find("input#biotic_percentage_hardbottom_total").value
    find("button#gotoSpecies").click
    # Samples, Species Section
    all("select[id$='animal_id']").first.select(animal1.spp_code_common)
    all("input[id$='number_individuals']").first.fill_in(with: "3")
    all("input[id$='average_length']").first.fill_in(with: "20")
    all("input[id$='min_length']").first.fill_in(with: "15")
    all("input[id$='max_length']").first.fill_in(with: "35")
    # Second species, from nested form
    find("a.add_nested_fields[data-association=sample_animals]").click # "Add New Species"
    all("select[id$='animal_id']").last.select(animal2.spp_code_common)
    all("input[id$='number_individuals']").last.fill_in(with: "2")
    all("input[id$='min_length']").last.fill_in(with: "10")
    all("input[id$='max_length']").last.fill_in(with: "12")
    # find("button#validateAnimals").click
    find("input[type=submit]").click

    assert_selector(".alert", text: "Sample was successfully created")

    assert_equal 1, Sample.count
  end
end
