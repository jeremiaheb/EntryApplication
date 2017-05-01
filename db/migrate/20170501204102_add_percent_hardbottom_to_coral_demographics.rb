class AddPercentHardbottomToCoralDemographics < ActiveRecord::Migration
  def change
    add_column :coral_demographics, :percent_hardbottom, :int
  end
end
