class RugosityMeasure < ActiveRecord::Base
  belongs_to :benthic_cover

  validates :min_depth,               :presence => true
  validates :max_depth,               :presence => true
  validates :rug_meters_completed,    :presence => true
  validates :meter_mark_1,            :presence => true,  if: -> { rug_meters_completed >= 1 }
  validates :meter_mark_2,            :presence => true,  if: -> { rug_meters_completed >= 2 } 
  validates :meter_mark_3,            :presence => true,  if: -> { rug_meters_completed >= 3 } 
  validates :meter_mark_4,            :presence => true,  if: -> { rug_meters_completed >= 4 }
  validates :meter_mark_5,            :presence => true,  if: -> { rug_meters_completed >= 5 }
  validates :meter_mark_6,            :presence => true,  if: -> { rug_meters_completed >= 6 }
  validates :meter_mark_7,            :presence => true,  if: -> { rug_meters_completed >= 7 }
  validates :meter_mark_8,            :presence => true,  if: -> { rug_meters_completed >= 8 }
  validates :meter_mark_9,            :presence => true,  if: -> { rug_meters_completed >= 9 }
  validates :meter_mark_10,           :presence => true,  if: -> { rug_meters_completed >= 10 }
  validates :meter_mark_11,           :presence => true,  if: -> { rug_meters_completed >= 11 }
  validates :meter_mark_12,           :presence => true,  if: -> { rug_meters_completed >= 12 }
  validates :meter_mark_13,           :presence => true,  if: -> { rug_meters_completed >= 13 }
  validates :meter_mark_14,           :presence => true,  if: -> { rug_meters_completed >= 14 }
  validates :meter_mark_15,           :presence => true,  if: -> { rug_meters_completed >= 15 }

  def category_sum
    [meter_mark_1, meter_mark_2, meter_mark_3, meter_mark_4, meter_mark_5, meter_mark_6, meter_mark_7, meter_mark_8, meter_mark_9, meter_mark_10,
    meter_mark_11, meter_mark_12, meter_mark_13, meter_mark_14, meter_mark_15].sum
  end
end
