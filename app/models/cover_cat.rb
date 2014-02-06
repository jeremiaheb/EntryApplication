class CoverCat < ActiveRecord::Base
  attr_protected []
  
  
  has_many :point_intercepts
  has_many :benthic_covers, :through => :point_intercepts
  accepts_nested_attributes_for :point_intercepts

  validates :name,   :presence => true

  def cover_code_name
    [self.code, self.name].join(" __ ")
  end

end
