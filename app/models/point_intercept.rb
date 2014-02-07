class PointIntercept < ActiveRecord::Base
  
  attr_protected []

  belongs_to  :benthic_cover
  belongs_to  :cover_cat

  validates   :cover_cat_id,    :presence => true

  def cover_total
    [hardbottom_num, softbottom_num, rubble_num].reject{|a| a.nil?}.sum
  end

end
