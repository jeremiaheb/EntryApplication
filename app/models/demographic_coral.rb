class DemographicCoral < ApplicationRecord
  belongs_to :coral_demographic
  belongs_to :coral

  default_scope -> { order("id ASC") }

  enum :restored, [:not_restored, :restored, :unknown]

  validates   :meter_mark, :max_diameter, :perpendicular_diameter, :height, :old_mortality, :recent_mortality, :bleach_condition, :disease, presence: true, if: -> { coral_id != 1 }
  validates   :max_diameter, :perpendicular_diameter, :height, numericality: { greater_than: 0 }
  validates   :perpendicular_diameter, numericality: { less_than_or_equal_to: :max_diameter }

  # One letter version of disease for use on the proofing report
  def disease_short
    disease[0].upcase
  end

  # One letter version of restored for use on the proofing report
  def restored_short
    {
      "not_restored" => "N",
      "restored" => "Y",
      "unknown" => "U",
    }.fetch(restored, nil)
  end
end
