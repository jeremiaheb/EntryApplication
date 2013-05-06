class CreateDemographicCorals < ActiveRecord::Migration
  def change
    create_table :demographic_corals do |t|
      t.integer :coral_demographic_id
      t.integer :coral_id
      t.float :max_diameter
      t.float :perpendicular_diameter
      t.float :height
      t.float :old_mortality
      t.float :recent_mortality
      t.string :bleach_condition

      t.timestamps
    end
  end
end
