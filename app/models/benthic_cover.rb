class BenthicCover < ActiveRecord::Base

  has_many :point_intercepts
  has_many :cover_cats, :through => :point_intercepts
  accepts_nested_attributes_for :point_intercepts

  belongs_to :diver
  belongs_to :habitat_type

  has_many    :invert_belts
  accepts_nested_attributes_for     :invert_belts
  has_many     :presence_belts
  accepts_nested_attributes_for     :presence_belts

end
