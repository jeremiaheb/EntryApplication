class RemoveSurfaceTemperatureAndSurfaceSalinityFromBoatLogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :boat_logs, :surface_temperature, :float
    remove_column :boat_logs, :surface_salinity, :float
  end
end
