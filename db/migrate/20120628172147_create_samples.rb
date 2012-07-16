class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :sample_type_id
      t.integer :habitat_type_id
      t.date    :sample_date
      t.time    :dive_begin_time
      t.time    :dive_end_time
      t.time    :sample_begin_time
      t.time    :sample_end_time
      t.integer :dive_depth
      t.integer :sample_depth
      t.text    :fishing_gear
      t.string  :field_id
      t.integer :underwater_visibility
      t.text    :sample_description
      t.integer :substrate_max_depth
      t.integer :substrate_min_depth
      t.float   :hard_verticle_relief
      t.float   :soft_verticle_relief
      t.integer :hard_relief_cat_0
      t.integer :hard_relief_cat_1
      t.integer :hard_relief_cat_2
      t.integer :hard_relief_cat_3
      t.integer :hard_relief_cat_4
      t.integer :soft_relief_cat_0
      t.integer :soft_relief_cat_1
      t.integer :soft_relief_cat_2
      t.integer :soft_relief_cat_3
      t.integer :soft_relief_cat_4
      t.integer :sand_percentage
      t.integer :hardbottom_percentage
      t.integer :rubble_percentage
      t.integer :sand_bare
      t.integer :sand_macro_algae
      t.integer :sand_seagrass
      t.integer :sand_sponge
      t.string  :sand_pcov_other1_lab
      t.string  :sand_pcov_other2_lab
      t.integer :sand_pcov_other1
      t.integer :sand_pcov_other2
      t.integer :hardbottom_algal_turf
      t.integer :hardbottom_macro_algae
      t.integer :hardbottom_live_coral
      t.integer :hardbottom_octocoral
      t.integer :hardbottom_sponge
      t.string  :hard_pcov_other1_lab
      t.string  :hard_pcov_other2_lab
      t.integer :hard_pcov_other1
      t.integer :hard_pcov_other2



      t.timestamps
    end
  end
end
