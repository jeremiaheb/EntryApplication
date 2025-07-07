class CreatePointIntercepts < ActiveRecord::Migration[5.1]
  def change
    create_table :point_intercepts do |t|
      t.integer :bethic_cover_id
      t.integer :cover_cat_id
      t.integer :hardbottom_num
      t.integer :softbottom_num
      t.integer :rubble_num
    end
  end
end
