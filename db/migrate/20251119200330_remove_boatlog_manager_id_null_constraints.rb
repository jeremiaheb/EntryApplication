class RemoveBoatlogManagerIdNullConstraints < ActiveRecord::Migration[7.2]
  def change
    change_column_null :boat_logs, :boatlog_manager_id, true
    change_column_null :benthic_covers, :boatlog_manager_id, true
    change_column_null :coral_demographics, :boatlog_manager_id, true
    change_column_null :samples, :boatlog_manager_id, true
  end
end
