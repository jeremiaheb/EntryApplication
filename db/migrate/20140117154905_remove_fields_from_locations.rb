class RemoveFieldsFromLocations < ActiveRecord::Migration
  def change
    remove_column :samples, :substrate_max_depth   
    remove_column :samples, :substrate_min_depth   
    remove_column :samples, :hard_verticle_relief  
    remove_column :samples, :soft_verticle_relief  
    remove_column :samples, :hard_relief_cat_0     
    remove_column :samples, :hard_relief_cat_1     
    remove_column :samples, :hard_relief_cat_2     
    remove_column :samples, :hard_relief_cat_3     
    remove_column :samples, :hard_relief_cat_4     
    remove_column :samples, :soft_relief_cat_0     
    remove_column :samples, :soft_relief_cat_1     
    remove_column :samples, :soft_relief_cat_2     
    remove_column :samples, :soft_relief_cat_3     
    remove_column :samples, :soft_relief_cat_4     
    remove_column :samples, :sand_bare             
    remove_column :samples, :sand_macro_algae      
    remove_column :samples, :sand_seagrass         
    remove_column :samples, :sand_sponge           
    remove_column :samples, :sand_pcov_other1_lab  
    remove_column :samples, :sand_pcov_other2_lab  
    remove_column :samples, :sand_pcov_other1      
    remove_column :samples, :sand_pcov_other2      
    remove_column :samples, :hardbottom_algal_turf 
    remove_column :samples, :hardbottom_macro_algae
    remove_column :samples, :hardbottom_live_coral 
    remove_column :samples, :hardbottom_octocoral  
    remove_column :samples, :hardbottom_sponge     
    remove_column :samples, :hard_pcov_other1_lab  
    remove_column :samples, :hard_pcov_other2_lab  
    remove_column :samples, :hard_pcov_other1      
    remove_column :samples, :hard_pcov_other2      
  end
end
