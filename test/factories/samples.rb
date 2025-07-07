FactoryGirl.define do
  factory :sample do
    sample_type
    habitat_type
    boatlog_manager
    sample_date Date.parse("2014-02-02")
    dive_begin_time Time.parse("2014-02-02T09:00:00Z")
    dive_end_time Time.parse("2014-02-02T09:45:00Z")
    sample_begin_time Time.parse("2014-02-02T09:05:00Z")
    sample_end_time Time.parse("2014-02-02T09:30:00Z")
    dive_depth 45
    sample_depth 45
    fishing_gear "none"
    field_id "10011a"
    underwater_visibility 50
    sample_description "none"
    sand_percentage 25
    hardbottom_percentage 75
    rubble_percentage 0
    water_temp 80
    current "none"
    substrate_max_depth 50
    substrate_min_depth 50
    hard_verticle_relief 1
    soft_verticle_relief 1
    hard_relief_cat_0 20
    hard_relief_cat_1 20
    hard_relief_cat_2 20
    hard_relief_cat_3 20
    hard_relief_cat_4 20
    soft_relief_cat_0 0
    soft_relief_cat_1 0
    soft_relief_cat_2 100
    soft_relief_cat_3 0
    soft_relief_cat_4 0
    sand_bare 100
    sand_macro_algae 0
    sand_seagrass 0
    sand_sponge 0
    sand_pcov_other1_lab "none"
    sand_pcov_other2_lab "none"
    sand_pcov_other1 0
    sand_pcov_other2 0
    hardbottom_algal_turf 25
    hardbottom_macro_algae 50
    hardbottom_live_coral 5
    hardbottom_octocoral 5
    hardbottom_sponge 5
    hard_pcov_other1_lab "Palythoa"
    hard_pcov_other2_lab "none"
    hard_pcov_other1 10
    hard_pcov_other2 0
  end
end
