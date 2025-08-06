class DiverSample < ApplicationRecord
  belongs_to :diver
  belongs_to :sample

  scope :primary, lambda { where(primary_diver: true) }
  scope :secondary, lambda { where(primary_diver: false) }

  validates :primary_diver, inclusion: [true, false]
  validates :diver_id, presence: true
end
