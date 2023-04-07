class DemographicCoral < ActiveRecord::Base
  attr_protected []

  belongs_to :coral_demographic
  belongs_to :coral

  default_scope -> { order("id ASC") }
  validates   :meter_mark, :max_diameter, :perpendicular_diameter, :height, :old_mortality, :recent_mortality, :bleach_condition, :disease, :presence => true, if: -> {coral_id != 1}
  validates   :max_diameter, :perpendicular_diameter, :height, :numericality => { :greater_than => 0 }
  validates   :perpendicular_diameter, :numericality => { :less_than_or_equal_to => :max_diameter }

end
