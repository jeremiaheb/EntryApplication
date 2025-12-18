class AddMissionIdNullConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :boat_logs, :mission_id, false
    change_column_null :benthic_covers, :mission_id, false
    change_column_null :coral_demographics, :mission_id, false
    change_column_null :samples, :mission_id, false
  end
end
