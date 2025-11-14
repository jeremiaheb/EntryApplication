class AddMissionIdToSamples < ActiveRecord::Migration[7.2]
  def change
    add_column :samples, :mission_id, :integer
    add_index :samples, :mission_id
  end
end
