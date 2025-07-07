class RemoveCylinderRadiusFromSamples < ActiveRecord::Migration[5.1]
  def up
    remove_column :samples, :cylinder_radius
      end

  def down
    add_column :samples, :cylinder_radius, :float
  end
end
