class AddPercentHardbottomToCoralDemographics < ActiveRecord::Migration[5.1]
  def change
    add_column :coral_demographics, :percent_hardbottom, :int
  end
end
