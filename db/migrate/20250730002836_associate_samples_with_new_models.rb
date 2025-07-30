class AssociateSamplesWithNewModels < ActiveRecord::Migration[7.1]
  def change
    add_column :samples, :region_id, :integer
    add_column :samples, :agency_id, :integer
    add_column :samples, :project_id, :integer

    add_index :samples, :region_id
    add_index :samples, :agency_id
    add_index :samples, :project_id
  end
end
