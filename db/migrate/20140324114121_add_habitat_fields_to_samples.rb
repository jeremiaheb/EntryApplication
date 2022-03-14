class AddHabitatFieldsToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :substrate_max_depth,    :integer   
    add_column :samples, :substrate_min_depth,    :integer   
    add_column :samples, :hard_verticle_relief,   :float 
    add_column :samples, :soft_verticle_relief,   :float  
    add_column :samples, :hard_relief_cat_0,      :integer     
    add_column :samples, :hard_relief_cat_1,      :integer     
    add_column :samples, :hard_relief_cat_2,      :integer     
    add_column :samples, :hard_relief_cat_3,      :integer     
    add_column :samples, :hard_relief_cat_4,      :integer     
    add_column :samples, :soft_relief_cat_0,      :integer     
    add_column :samples, :soft_relief_cat_1,      :integer     
    add_column :samples, :soft_relief_cat_2,      :integer     
    add_column :samples, :soft_relief_cat_3,      :integer     
    add_column :samples, :soft_relief_cat_4,      :integer     
    add_column :samples, :sand_bare,              :integer             
    add_column :samples, :sand_macro_algae,       :integer      
    add_column :samples, :sand_seagrass,          :integer         
    add_column :samples, :sand_sponge,            :integer           
    add_column :samples, :sand_pcov_other1_lab,   :string  
    add_column :samples, :sand_pcov_other2_lab,   :string  
    add_column :samples, :sand_pcov_other1,       :integer      
    add_column :samples, :sand_pcov_other2,       :integer      
    add_column :samples, :hardbottom_algal_turf,  :integer 
    add_column :samples, :hardbottom_macro_algae, :integer
    add_column :samples, :hardbottom_live_coral,  :integer 
    add_column :samples, :hardbottom_octocoral,   :integer  
    add_column :samples, :hardbottom_sponge,      :integer     
    add_column :samples, :hard_pcov_other1_lab,   :string  
    add_column :samples, :hard_pcov_other2_lab,   :string  
    add_column :samples, :hard_pcov_other1,       :integer      
    add_column :samples, :hard_pcov_other2,       :integer      
  end
end
