class CreateMissions < ActiveRecord::Migration[7.1]
  def change
    create_table :missions do |t|
      t.integer :project_id, null: false
      t.integer :agency_id, null: false
      t.integer :jurisdiction_id, null: false

      t.index [:project_id, :agency_id, :jurisdiction_id], unique: true

      t.timestamps null: false
    end
  end
end
