class DropUnusedTables < ActiveRecord::Migration
  def up
    drop_table :covers
    drop_table :line_points
    drop_table :line_point_covers

  end

  def down 
  end
end
