class RenameJurisdictionsToRegions < ActiveRecord::Migration[7.1]
  def change
    rename_table :jurisdictions, :regions
    rename_table :jurisdiction_habitat_types, :region_habitat_types
    rename_column :region_habitat_types, :jurisdiction_id, :region_id
    rename_column :missions, :jurisdiction_id, :region_id
  end
end
