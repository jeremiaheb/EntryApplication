class CreateDiverSamples < ActiveRecord::Migration
  def change
    create_table :diver_samples do |t|

      t.timestamps
    end
  end
end
