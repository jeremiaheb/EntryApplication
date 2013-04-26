class PointIntercept < ActiveRecord::Base
  
  belongs_to  :benthic_cover
  belongs_to  :cover_cat


  def cover_total
    return [self.hardbottom_num, self.softbottom_num, self.rubble_num].reject{|a| a.nil?}.sum
  end

end
