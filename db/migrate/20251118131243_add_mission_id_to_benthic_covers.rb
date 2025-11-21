class AddMissionIdToBenthicCovers < ActiveRecord::Migration[7.2]
  def change
    add_column :benthic_covers, :mission_id, :integer
    add_index :benthic_covers, :mission_id
  end
end
