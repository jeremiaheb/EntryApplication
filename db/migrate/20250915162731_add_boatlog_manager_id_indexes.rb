class AddBoatlogManagerIdIndexes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :boat_logs, :boatlog_manager_id, false
    add_index :boat_logs, :boatlog_manager_id

    change_column_null :samples, :boatlog_manager_id, false
    add_index :samples, :boatlog_manager_id

    change_column_null :benthic_covers, :boatlog_manager_id, false
    add_index :benthic_covers, :boatlog_manager_id

    change_column_null :coral_demographics, :boatlog_manager_id, false
    add_index :coral_demographics, :boatlog_manager_id
  end
end
