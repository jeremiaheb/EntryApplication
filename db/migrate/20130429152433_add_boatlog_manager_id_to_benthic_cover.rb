class AddBoatlogManagerIdToBenthicCover < ActiveRecord::Migration[5.1]
  def change
    add_column :benthic_covers, :boatlog_manager_id, :integer

  end
end
