class AddMissionIdToBoatLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :boat_logs, :mission_id, :integer
    add_index :boat_logs, :mission_id
  end
end
