# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130426201924) do

  create_table "animals", :force => true do |t|
    t.string   "species_code"
    t.string   "scientific_name"
    t.string   "common_name"
    t.integer  "max_size"
    t.integer  "min_size"
    t.integer  "max_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "benthic_covers", :force => true do |t|
    t.integer  "diver_id"
    t.integer  "habitat_type_id"
    t.integer  "buddy"
    t.string   "field_id"
    t.date     "sample_date"
    t.time     "sample_begin_time"
    t.integer  "meters_completed"
    t.text     "sample_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "boatlog_managers", :force => true do |t|
    t.string   "agency"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cover_cats", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "covers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "diver_samples", :force => true do |t|
    t.integer  "sample_id"
    t.integer  "diver_id"
    t.boolean  "primary_diver"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "divers", :force => true do |t|
    t.string   "diver_number"
    t.string   "diver_name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "active"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "role"
    t.integer  "boatlog_manager_id"
  end

  create_table "habitat_types", :force => true do |t|
    t.string   "habitat_name"
    t.string   "habitat_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "invert_belts", :force => true do |t|
    t.integer "benthic_cover_id"
    t.integer "lobster_num"
    t.integer "conch_num"
    t.integer "diadema_num"
  end

  create_table "line_point_covers", :force => true do |t|
    t.integer  "line_point_id"
    t.integer  "cover_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "hardbottom_num"
    t.integer  "sand_num"
    t.integer  "rubble_num"
  end

  create_table "line_points", :force => true do |t|
    t.string   "field_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "point_intercepts", :force => true do |t|
    t.integer "benthic_cover_id"
    t.integer "cover_cat_id"
    t.integer "hardbottom_num"
    t.integer "softbottom_num"
    t.integer "rubble_num"
  end

  create_table "presence_belts", :force => true do |t|
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

  create_table "sample_animals", :force => true do |t|
    t.integer "sample_id"
    t.integer "animal_id"
    t.integer "number_individuals"
    t.integer "average_length"
    t.integer "min_length"
    t.integer "max_length"
    t.integer "time_seen"
  end

  create_table "sample_types", :force => true do |t|
    t.string   "sample_type_name"
    t.string   "sample_type_description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "samples", :force => true do |t|
    t.integer  "sample_type_id"
    t.integer  "habitat_type_id"
    t.date     "sample_date"
    t.time     "dive_begin_time"
    t.time     "dive_end_time"
    t.time     "sample_begin_time"
    t.time     "sample_end_time"
    t.integer  "dive_depth"
    t.integer  "sample_depth"
    t.text     "fishing_gear"
    t.string   "field_id"
    t.integer  "underwater_visibility"
    t.text     "sample_description"
    t.integer  "substrate_max_depth"
    t.integer  "substrate_min_depth"
    t.float    "hard_verticle_relief"
    t.float    "soft_verticle_relief"
    t.integer  "hard_relief_cat_0"
    t.integer  "hard_relief_cat_1"
    t.integer  "hard_relief_cat_2"
    t.integer  "hard_relief_cat_3"
    t.integer  "hard_relief_cat_4"
    t.integer  "soft_relief_cat_0"
    t.integer  "soft_relief_cat_1"
    t.integer  "soft_relief_cat_2"
    t.integer  "soft_relief_cat_3"
    t.integer  "soft_relief_cat_4"
    t.integer  "sand_percentage"
    t.integer  "hardbottom_percentage"
    t.integer  "rubble_percentage"
    t.integer  "sand_bare"
    t.integer  "sand_macro_algae"
    t.integer  "sand_seagrass"
    t.integer  "sand_sponge"
    t.string   "sand_pcov_other1_lab"
    t.string   "sand_pcov_other2_lab"
    t.integer  "sand_pcov_other1"
    t.integer  "sand_pcov_other2"
    t.integer  "hardbottom_algal_turf"
    t.integer  "hardbottom_macro_algae"
    t.integer  "hardbottom_live_coral"
    t.integer  "hardbottom_octocoral"
    t.integer  "hardbottom_sponge"
    t.string   "hard_pcov_other1_lab"
    t.string   "hard_pcov_other2_lab"
    t.integer  "hard_pcov_other1"
    t.integer  "hard_pcov_other2"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.float    "water_temp"
    t.float    "cylinder_radius"
    t.string   "current"
    t.integer  "boatlog_manager_id"
  end

end
