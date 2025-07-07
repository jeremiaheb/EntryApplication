class CreateRepLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :rep_logs do |t|
      t.integer :station_log_id
      t.string :replicate
      t.integer :diver_id

      t.timestamps
    end
  end
end
