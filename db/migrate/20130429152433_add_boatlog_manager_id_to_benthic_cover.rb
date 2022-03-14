class AddBoatlogManagerIdToBenthicCover < ActiveRecord::Migration
  def change
    add_column :benthic_covers, :boatlog_manager_id, :integer

  end
end
