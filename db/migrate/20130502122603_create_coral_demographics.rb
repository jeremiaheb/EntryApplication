class CreateCoralDemographics < ActiveRecord::Migration
  def change
    create_table :coral_demographics do |t|
      t.integer :diver_id
      t.integer :habitat_type_id
      t.integer :buddy
      t.string :field_id
      t.date :sample_date
      t.time :sample_begin_time
      t.integer :meters_completed
      t.text :sample_description

      t.timestamps
    end
  end
end
