class AddBoatlogManagerIdToCoralDemographic < ActiveRecord::Migration
  def change
    add_column :coral_demographics, :boatlog_manager_id, :integer

  end
end
