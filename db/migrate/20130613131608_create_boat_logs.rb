class CreateBoatLogs < ActiveRecord::Migration
  def change
    create_table :boat_logs do |t|
      t.string :primary_sample_unit
      t.date :date
      t.integer :boatlog_manager_id
      t.float :surface_temperature
      t.float :surface_salinity

      t.timestamps
    end
  end
end
