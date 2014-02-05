class RugosityMeasure < ActiveRecord::Base
  attr_protected []

belongs_to :benthic_cover

  validates :min_depth,               :presence => true
  validates :max_depth,               :presence => true
  validates :max_vert_height,         :presence => true
  validates :cnt_less_than_20,        :presence => true
  validates :cnt_20_less_than_50,     :presence => true
  validates :cnt_50_less_than_100,    :presence => true
  validates :cnt_100_less_than_150,   :presence => true
  validates :cnt_150_less_than_200,   :presence => true
  validates :cnt_greater_than_200,    :presence => true


end
