class CreateMissionManagers < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_managers do |t|
      t.integer :mission_id, null: false
      t.integer :diver_id, null: false

      t.timestamps null: false
      t.index [:mission_id, :diver_id], unique: true
    end
  end
end
