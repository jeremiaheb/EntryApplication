class ChangeMaxVertInRugosityMeasures < ActiveRecord::Migration
  def change

    rename_column :rugosity_measures, :max_vert_height,       :rug_meters_completed
    change_column :rugosity_measures, :rug_meters_completed,  :integer

  end
end
