class EditStationLogsCoordinateFields < ActiveRecord::Migration[5.1]
  def up
    remove_column :station_logs, :flag_coordiates
    remove_column :station_logs, :boat_coordiantes

    add_column :station_logs, :latitude, :decimal
    add_column :station_logs, :longitude, :decimal

  end

  def down
  end
end
