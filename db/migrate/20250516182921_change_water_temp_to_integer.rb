class ChangeWaterTempToInteger < ActiveRecord::Migration[5.1]
  def up
    change_column :samples, :water_temp, :integer
  end

  def down
    change_column :samples, :water_temp, :float
  end
end
