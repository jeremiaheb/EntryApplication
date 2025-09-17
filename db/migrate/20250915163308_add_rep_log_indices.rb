class AddRepLogIndices < ActiveRecord::Migration[7.1]
  def change
    change_column_null :rep_logs, :diver_id, false
    add_index :rep_logs, :diver_id

    change_column_null :rep_logs, :station_log_id, false
    add_index :rep_logs, :station_log_id

    change_column_null :station_logs, :boat_log_id, false
    add_index :station_logs, :boat_log_id
  end
end
