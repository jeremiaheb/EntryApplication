class LinePoint < ActiveRecord::Base
  
  has_many :line_point_covers, :dependent => :destroy
  has_many :covers, :through => :line_point_covers
  accepts_nested_attributes_for :line_point_covers, :reject_if => lambda {  |a| a[:cover_id].blank? }, :allow_destroy => true

end
