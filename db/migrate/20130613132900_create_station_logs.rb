class CreateStationLogs < ActiveRecord::Migration
  def change
    create_table :station_logs do |t|
      t.integer :boat_log_id
      t.integer :stn_number
      t.time :time
      t.string :boat_coordiantes
      t.string :flag_coordiates
      t.text :comments

      t.timestamps
    end
  end
end
