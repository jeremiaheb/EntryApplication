class BoatlogManager < ApplicationRecord
  has_many  :samples, dependent: :restrict_with_error
  has_one   :diver
  has_many  :benthic_covers, dependent: :restrict_with_error
  has_many  :coral_demographics, dependent: :restrict_with_error
  has_many  :boat_logs, dependent: :restrict_with_error

  def agency_name
    "#{agency}/#{lastname}"
  end

  validates :agency, :firstname, :lastname, presence: true

  def divers_responsible_for
    boatlog_replicate_divers = boat_logs.includes([:divers]).flat_map(&:divers)
    sample_divers = samples.includes([:diver]).map(&:diver)
    lpi_divers = benthic_covers.includes([:diver]).map(&:diver)
    demo_divers = coral_demographics.includes([:diver]).map(&:diver)
    (boatlog_replicate_divers + sample_divers + lpi_divers + demo_divers).uniq.sort_by(&:diver_name)
  end
end
