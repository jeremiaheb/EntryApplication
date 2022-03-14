class RemoveCylinderRadiusFromSamples < ActiveRecord::Migration
  def up
    remove_column :samples, :cylinder_radius
      end

  def down
    add_column :samples, :cylinder_radius, :float
  end
end
