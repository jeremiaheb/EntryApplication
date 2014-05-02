class DemographicCoral < ActiveRecord::Base
  attr_protected []

  belongs_to :coral_demographic
  belongs_to :coral


  validates   :max_diameter, :perpendicular_diameter, :height, :old_mortality, :recent_mortality, :bleach_condition, :disease,    :presence => true, :if => "coral_id != 1"



end
