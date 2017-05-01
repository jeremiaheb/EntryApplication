class AddMeterMarkToDemographicCorals < ActiveRecord::Migration
  def change
    add_column :demographic_corals, :meter_mark, :int
  end
end
