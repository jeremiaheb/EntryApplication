class CoverCat < ActiveRecord::Base
  has_many :point_intercepts
  has_many :benthic_covers, through: :point_intercepts
  accepts_nested_attributes_for :point_intercepts

  validates :name, presence: true
  validates :code, presence: true
  validates :proofing_code, presence: true

  def display_name
    [self.code, self.proofing_code].join(" __ ")
  end
end
