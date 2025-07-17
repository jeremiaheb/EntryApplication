class CreateRugosityMeasures < ActiveRecord::Migration[5.1]
  def change
    create_table :rugosity_measures do |t|
      t.integer :benthic_cover_id
      t.integer :min_depth
      t.integer :max_depth
      t.float   :max_vert_height
      t.integer :cnt_less_than_20
      t.integer :cnt_20_less_than_50
      t.integer :cnt_50_less_than_100
      t.integer :cnt_100_less_than_150
      t.integer :cnt_150_less_than_200
      t.integer :cnt_greater_than_200
    end
  end
end
