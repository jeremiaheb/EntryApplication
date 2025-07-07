class AddBoatlogManagerIdToCoralDemographic < ActiveRecord::Migration[5.1]
  def change
    add_column :coral_demographics, :boatlog_manager_id, :integer

  end
end
