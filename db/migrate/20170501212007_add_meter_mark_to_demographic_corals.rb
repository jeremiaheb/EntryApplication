class AddMeterMarkToDemographicCorals < ActiveRecord::Migration[5.1]
  def change
    add_column :demographic_corals, :meter_mark, :int
  end
end
