class RugosityMeasure < ActiveRecord::Base
  attr_protected []

belongs_to :benthic_cover

  validates :min_depth,               :presence => true
  validates :max_depth,               :presence => true
  validates :max_vert_height,         :presence => true
  validates :meter_mark_1,            :presence => true
  validates :meter_mark_2,            :presence => true
  validates :meter_mark_3,            :presence => true
  validates :meter_mark_4,            :presence => true
  validates :meter_mark_5,            :presence => true
  validates :meter_mark_6,            :presence => true
  validates :meter_mark_7,            :presence => true
  validates :meter_mark_8,            :presence => true
  validates :meter_mark_9,            :presence => true
  validates :meter_mark_10,            :presence => true
  validates :meter_mark_11,            :presence => true
  validates :meter_mark_12,            :presence => true
  validates :meter_mark_13,            :presence => true
  validates :meter_mark_14,            :presence => true
  validates :meter_mark_15,            :presence => true


  def category_sum
    [cnt_less_than_20, cnt_20_less_than_50, cnt_50_less_than_100, cnt_100_less_than_150, cnt_150_less_than_200, cnt_greater_than_200].sum
  end
end
