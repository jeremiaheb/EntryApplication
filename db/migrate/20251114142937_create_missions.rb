class CreateMissions < ActiveRecord::Migration[7.2]
  def change
    create_table :missions do |t|
      t.integer :project_id, null: false
      t.integer :agency_id, null: false
      t.integer :region_id, null: false
      t.boolean :active, default: true, null: false

      t.timestamps null: false
      t.index :active
      t.index [:project_id, :agency_id, :region_id], unique: true
    end
  end
end
