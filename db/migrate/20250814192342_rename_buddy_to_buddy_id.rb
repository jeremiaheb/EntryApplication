class RenameBuddyToBuddyId < ActiveRecord::Migration[7.1]
  def change
    rename_column :benthic_covers, :buddy, :buddy_id
    rename_column :coral_demographics, :buddy, :buddy_id
  end
end
