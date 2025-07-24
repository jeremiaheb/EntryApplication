class AddMissionIdToSamples < ActiveRecord::Migration[7.1]
  def change
    add_column :samples, :mission_id, :integer
  end
end
