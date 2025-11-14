class AddMissionIdToCoralDemographics < ActiveRecord::Migration[7.2]
  def change
    add_column :coral_demographics, :mission_id, :integer
    add_index :coral_demographics, :mission_id
  end
end
