class AddBoatlogManagerIdToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :boatlog_manager_id, :integer

  end
end
