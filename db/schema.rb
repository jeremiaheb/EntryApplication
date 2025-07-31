# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_31_002324) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_agencies_on_name", unique: true
  end

  create_table "animals", force: :cascade do |t|
    t.string "species_code"
    t.string "scientific_name"
    t.string "common_name"
    t.integer "max_size"
    t.integer "min_size"
    t.integer "max_number"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "benthic_covers", force: :cascade do |t|
    t.integer "diver_id"
    t.integer "habitat_type_id"
    t.integer "buddy"
    t.string "field_id"
    t.date "sample_date"
    t.time "sample_begin_time"
    t.integer "meters_completed"
    t.text "sample_description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "boatlog_manager_id"
  end

  create_table "boat_logs", force: :cascade do |t|
    t.string "primary_sample_unit"
    t.date "date"
    t.integer "boatlog_manager_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "boatlog_managers", force: :cascade do |t|
    t.string "agency"
    t.string "firstname"
    t.string "lastname"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "coral_demographics", force: :cascade do |t|
    t.integer "diver_id"
    t.integer "habitat_type_id"
    t.integer "buddy"
    t.string "field_id"
    t.date "sample_date"
    t.time "sample_begin_time"
    t.integer "meters_completed"
    t.text "sample_description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "boatlog_manager_id"
    t.integer "percent_hardbottom"
  end

  create_table "corals", force: :cascade do |t|
    t.string "code", null: false
    t.string "scientific_name", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "common_name"
    t.string "short_code", null: false
    t.integer "rank", default: 2147483647, null: false
  end

  create_table "cover_cats", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "code", null: false
    t.string "common"
    t.string "proofing_code", null: false
    t.integer "rank", default: 2147483647, null: false
  end

  create_table "demographic_corals", force: :cascade do |t|
    t.integer "coral_demographic_id"
    t.integer "coral_id"
    t.integer "max_diameter"
    t.integer "perpendicular_diameter"
    t.integer "height"
    t.integer "old_mortality"
    t.integer "recent_mortality"
    t.string "bleach_condition"
    t.string "disease"
    t.integer "meter_mark"
  end

  create_table "diver_samples", force: :cascade do |t|
    t.integer "sample_id"
    t.integer "diver_id"
    t.boolean "primary_diver"
  end

  create_table "divers", force: :cascade do |t|
    t.string "diver_number"
    t.string "diver_name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "active"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.string "role", default: "diver", null: false
    t.integer "boatlog_manager_id"
    t.index ["boatlog_manager_id"], name: "index_divers_on_boatlog_manager_id", unique: true
  end

  create_table "drafts", force: :cascade do |t|
    t.bigint "diver_id"
    t.string "model_klass", null: false
    t.integer "model_id"
    t.json "model_attributes", default: "{}", null: false
    t.string "focused_dom_id"
    t.float "sequence", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["diver_id", "model_klass", "model_id", "sequence"], name: "idx_on_diver_id_model_klass_model_id_sequence_3f81240dbe", unique: true, order: { sequence: :desc }
  end

  create_table "habitat_types", force: :cascade do |t|
    t.string "habitat_name"
    t.string "habitat_description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "region"
  end

  create_table "invert_belts", force: :cascade do |t|
    t.integer "benthic_cover_id"
    t.integer "lobster_num"
    t.integer "conch_num"
    t.integer "diadema_num"
  end

  create_table "mission_managers", force: :cascade do |t|
    t.integer "mission_id", null: false
    t.integer "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id", "manager_id"], name: "index_mission_managers_on_mission_id_and_manager_id", unique: true
  end

  create_table "missions", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "agency_id", null: false
    t.integer "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["active"], name: "index_missions_on_active"
    t.index ["project_id", "agency_id", "region_id"], name: "index_missions_on_project_id_and_agency_id_and_region_id", unique: true
  end

  create_table "point_intercepts", force: :cascade do |t|
    t.integer "benthic_cover_id"
    t.integer "cover_cat_id"
    t.integer "hardbottom_num"
    t.integer "softbottom_num"
    t.integer "rubble_num"
  end

  create_table "presence_belts", force: :cascade do |t|
    t.integer "benthic_cover_id"
    t.integer "a_palmata"
    t.integer "a_cervicornis"
    t.integer "d_cylindrus"
    t.integer "m_ferox"
    t.integer "m_annularis"
    t.integer "m_franksi"
    t.integer "m_faveolata"
    t.integer "d_stokesii"
    t.integer "a_lamarcki"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_projects_on_name", unique: true
  end

  create_table "region_habitat_types", force: :cascade do |t|
    t.integer "region_id", null: false
    t.integer "habitat_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id", "habitat_type_id"], name: "index_region_habitat_types_on_region_id_and_habitat_type_id", unique: true
  end

  create_table "regions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_regions_on_name", unique: true
  end

  create_table "rep_logs", force: :cascade do |t|
    t.integer "station_log_id"
    t.string "replicate"
    t.integer "diver_id"
  end

  create_table "rugosity_measures", force: :cascade do |t|
    t.integer "benthic_cover_id"
    t.integer "min_depth"
    t.integer "max_depth"
    t.integer "rug_meters_completed"
    t.integer "meter_mark_1"
    t.integer "meter_mark_2"
    t.integer "meter_mark_3"
    t.integer "meter_mark_4"
    t.integer "meter_mark_5"
    t.integer "meter_mark_6"
    t.integer "meter_mark_7"
    t.integer "meter_mark_8"
    t.integer "meter_mark_9"
    t.integer "meter_mark_10"
    t.integer "meter_mark_11"
    t.integer "meter_mark_12"
    t.integer "meter_mark_13"
    t.integer "meter_mark_14"
    t.integer "meter_mark_15"
  end

  create_table "sample_animals", force: :cascade do |t|
    t.integer "sample_id"
    t.integer "animal_id"
    t.integer "number_individuals"
    t.integer "average_length"
    t.integer "min_length"
    t.integer "max_length"
    t.integer "time_seen"
  end

  create_table "sample_types", force: :cascade do |t|
    t.string "sample_type_name"
    t.string "sample_type_description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "samples", force: :cascade do |t|
    t.integer "sample_type_id"
    t.integer "habitat_type_id"
    t.date "sample_date"
    t.time "dive_begin_time"
    t.time "dive_end_time"
    t.time "sample_begin_time"
    t.time "sample_end_time"
    t.integer "dive_depth"
    t.integer "sample_depth"
    t.text "fishing_gear"
    t.string "field_id"
    t.integer "underwater_visibility"
    t.text "sample_description"
    t.integer "sand_percentage"
    t.integer "hardbottom_percentage"
    t.integer "rubble_percentage"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "water_temp"
    t.string "current"
    t.integer "boatlog_manager_id"
    t.integer "substrate_max_depth"
    t.integer "substrate_min_depth"
    t.float "hard_verticle_relief"
    t.float "soft_verticle_relief"
    t.integer "hard_relief_cat_0"
    t.integer "hard_relief_cat_1"
    t.integer "hard_relief_cat_2"
    t.integer "hard_relief_cat_3"
    t.integer "hard_relief_cat_4"
    t.integer "soft_relief_cat_0"
    t.integer "soft_relief_cat_1"
    t.integer "soft_relief_cat_2"
    t.integer "soft_relief_cat_3"
    t.integer "soft_relief_cat_4"
    t.integer "sand_bare"
    t.integer "sand_macro_algae"
    t.integer "sand_seagrass"
    t.integer "sand_sponge"
    t.string "sand_pcov_other1_lab"
    t.string "sand_pcov_other2_lab"
    t.integer "sand_pcov_other1"
    t.integer "sand_pcov_other2"
    t.integer "hardbottom_algal_turf"
    t.integer "hardbottom_macro_algae"
    t.integer "hardbottom_live_coral"
    t.integer "hardbottom_octocoral"
    t.integer "hardbottom_sponge"
    t.string "hard_pcov_other1_lab"
    t.string "hard_pcov_other2_lab"
    t.integer "hard_pcov_other1"
    t.integer "hard_pcov_other2"
    t.integer "diver_id"
    t.integer "buddy_id"
    t.integer "region_id"
    t.integer "agency_id"
    t.integer "project_id"
    t.index ["agency_id"], name: "index_samples_on_agency_id"
    t.index ["buddy_id"], name: "index_samples_on_buddy_id"
    t.index ["diver_id"], name: "index_samples_on_diver_id"
    t.index ["project_id"], name: "index_samples_on_project_id"
    t.index ["region_id"], name: "index_samples_on_region_id"
  end

  create_table "station_logs", force: :cascade do |t|
    t.integer "boat_log_id"
    t.integer "stn_number"
    t.time "time"
    t.text "comments"
    t.float "latitude"
    t.float "longitude"
  end

end
