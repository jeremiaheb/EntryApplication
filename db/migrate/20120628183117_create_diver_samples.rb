class CreateDiverSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :diver_samples do |t|
      t.integer   :sample_id
      t.integer   :diver_id
      t.boolean   :primary_diver

      t.timestamps
    end
  end
end
