class TallyMark < ApplicationRecord
  belongs_to :benthic_cover
  belongs_to :cover_cat, optional: true

  validates :meter_mark, presence: true, uniqueness: { scope: [:benthic_cover_id] }
end
