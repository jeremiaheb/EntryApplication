class AddWaterTempAndCylinderRadiusAndCurrentToSamples < ActiveRecord::Migration[5.1]
  def change
    add_column :samples, :water_temp, :float

    add_column :samples, :cylinder_radius, :float

    add_column :samples, :current, :string

  end
end
