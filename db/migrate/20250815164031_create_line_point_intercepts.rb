class CreateLinePointIntercepts < ActiveRecord::Migration[7.1]
  def change
    create_table :line_point_intercepts do |t|
      t.column :benthic_cover_id, :integer, null: false
      t.column :meter_mark, :decimal, precision: 5, scale: 2, null: false
      t.column :cover_cat_id, :integer, null: true
      t.column :habitat, :integer, null: true

      t.timestamps null: false

      t.index [:benthic_cover_id, :meter_mark], unique: true
    end
  end
end
