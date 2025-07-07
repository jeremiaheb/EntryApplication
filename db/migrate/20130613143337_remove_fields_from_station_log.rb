class RemoveFieldsFromStationLog < ActiveRecord::Migration[5.1]
  def up
    remove_column :station_logs, :created_at
        remove_column :station_logs, :updated_at
      end

  def down
    add_column :station_logs, :updated_at, :datetime
    add_column :station_logs, :created_at, :datetime
  end
end
