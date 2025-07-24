class CreateJurisdictionHabitatTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :jurisdiction_habitat_types do |t|
      t.integer :jurisdiction_id, null: false
      t.integer :habitat_type_id, null: false

      t.index [:jurisdiction_id, :habitat_type_id], unique: true

      t.timestamps null: false
    end
  end
end
