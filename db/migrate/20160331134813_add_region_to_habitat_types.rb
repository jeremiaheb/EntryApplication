class AddRegionToHabitatTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :habitat_types, :region, :string
  end
end
