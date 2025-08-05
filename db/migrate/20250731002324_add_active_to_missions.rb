class AddActiveToMissions < ActiveRecord::Migration[7.1]
  def change
    add_column :missions, :active, :boolean, default: true, null: false
    add_index :missions, :active
  end
end
