class DemographicCoral < ApplicationRecord
  belongs_to :coral_demographic
  belongs_to :coral

  default_scope -> { order("id ASC") }

  enum :restored, [:not_restored, :restored, :unknown], scopes: false, instance_methods: false

  validates   :meter_mark, presence: true
  validates   :juvenile, inclusion: { in: [true, false] }
  validates   :height, presence: true, numericality: { greater_than: 0 }

  # For juveniles, only meter mark and height (tally) are required
  validates   :max_diameter, :perpendicular_diameter, :old_mortality, :recent_mortality, :bleach_condition, :disease, presence: true, unless: :juvenile?
  validates   :max_diameter, :perpendicular_diameter, numericality: { greater_than: 0 }, unless: :juvenile?
  validates   :perpendicular_diameter, numericality: { less_than_or_equal_to: :max_diameter }, unless: :juvenile?

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
