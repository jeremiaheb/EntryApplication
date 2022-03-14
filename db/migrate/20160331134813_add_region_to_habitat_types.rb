class AddRegionToHabitatTypes < ActiveRecord::Migration
  def change
    add_column :habitat_types, :region, :string
  end
end
