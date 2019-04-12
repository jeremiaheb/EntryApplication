class RemoveRugosityBinsFromRugosityMeasures < ActiveRecord::Migration
  def change
    remove_column :rugosity_measures, :cnt_less_than_20,      :integer
    remove_column :rugosity_measures, :cnt_20_less_than_50,   :integer
    remove_column :rugosity_measures, :cnt_50_less_than_100,  :integer
    remove_column :rugosity_measures, :cnt_100_less_than_150, :integer
    remove_column :rugosity_measures, :cnt_150_less_than_200, :integer
    remove_column :rugosity_measures, :cnt_greater_than_200,  :integer
  end
end
