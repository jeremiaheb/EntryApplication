class AddWaterTempAndCylinderRadiusAndCurrentToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :water_temp, :float

    add_column :samples, :cylinder_radius, :float

    add_column :samples, :current, :string

  end
end
