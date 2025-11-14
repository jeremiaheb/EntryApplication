class CreateRegionHabitatTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :region_habitat_types do |t|
      t.integer :region_id, null: false
      t.integer :habitat_type_id, null: false

      t.timestamps null: false
      t.index [:region_id, :habitat_type_id], unique: true
    end
  end
end
