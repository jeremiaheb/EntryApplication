class DemographicCoral < ActiveRecord::Base

  belongs_to :coral_demographic
  belongs_to :coral


  validates   :max_diameter, :perpendicular_diameter, :height, :old_mortality, :recent_mortality, :bleach_condition,    :presence => true, :if => "coral_id != 1"



end
