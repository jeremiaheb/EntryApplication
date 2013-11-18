class CoverCat < ActiveRecord::Base
  
  
  has_many :point_intercepts
  has_many :benthic_covers, :through => :point_intercepts
  accepts_nested_attributes_for :point_intercepts

  validates :name,   :presence => true

end
