class AddBoatlogManagerIdToSamples < ActiveRecord::Migration[5.1]
  def change
    add_column :samples, :boatlog_manager_id, :integer
  end
end
