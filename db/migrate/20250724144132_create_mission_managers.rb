class CreateMissionManagers < ActiveRecord::Migration[7.1]
  def change
    create_table :mission_managers do |t|
      t.integer :mission_id, null: false
      t.integer :manager_id, null: false

      t.index [:mission_id, :manager_id], unique: true

      t.timestamps null: false
    end
  end
end
