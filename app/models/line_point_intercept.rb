class LinePointIntercept < ApplicationRecord
  belongs_to :benthic_cover
  belongs_to :cover_cat, optional: true

  validates :benthic_cover_id, presence: true
  validates :meter_mark, presence: true, uniqueness: { scope: [:benthic_cover_id] }

  HABITATS = {
    "hard" => 0,
    "soft" => 1,
    "rubble" => 2,
  }.freeze
  enum habitat: HABITATS
end
