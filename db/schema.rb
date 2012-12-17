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

ActiveRecord::Schema.define(:version => 20121217132926) do

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
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "active",       :default => false
  end

  create_table "habitat_types", :force => true do |t|
    t.string   "habitat_name"
    t.string   "habitat_description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
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
  end

end
