class ChangeCoordinateTypeInStationLogs < ActiveRecord::Migration
  def up
    change_column :station_logs, :latitude, :float
    change_column :station_logs, :longitude, :float

  end

  def down
  end
end
