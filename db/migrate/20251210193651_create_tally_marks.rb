class CreateTallyMarks < ActiveRecord::Migration[8.0]
  def change
    create_table :tally_marks do |t|
      t.decimal :meter_mark, precision: 7, scale: 2, null: false
      t.integer :benthic_cover_id, null: false
      t.integer :cover_cat_id
      t.string :habitat

      t.timestamps null: false

      t.index [:benthic_cover_id, :meter_mark], unique: true
    end
  end
end
