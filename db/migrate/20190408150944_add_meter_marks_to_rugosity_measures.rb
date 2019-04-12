class AddMeterMarksToRugosityMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :rugosity_measures, :meter_mark_1,   :integer
    add_column :rugosity_measures, :meter_mark_2,   :integer
    add_column :rugosity_measures, :meter_mark_3,   :integer
    add_column :rugosity_measures, :meter_mark_4,   :integer
    add_column :rugosity_measures, :meter_mark_5,   :integer
    add_column :rugosity_measures, :meter_mark_6,   :integer
    add_column :rugosity_measures, :meter_mark_7,   :integer
    add_column :rugosity_measures, :meter_mark_8,   :integer
    add_column :rugosity_measures, :meter_mark_9,   :integer
    add_column :rugosity_measures, :meter_mark_10,  :integer
    add_column :rugosity_measures, :meter_mark_11,  :integer
    add_column :rugosity_measures, :meter_mark_12,  :integer
    add_column :rugosity_measures, :meter_mark_13,  :integer
    add_column :rugosity_measures, :meter_mark_14,  :integer
    add_column :rugosity_measures, :meter_mark_15,  :integer
  end
end
