class CoverCat < ApplicationRecord
  has_many :point_intercepts, dependent: :restrict_with_error
  has_many :benthic_covers, through: :point_intercepts

  validates :name, presence: true
  validates :code, presence: true
  validates :proofing_code, presence: true

  def display_name
    [self.code, self.proofing_code].join(" __ ")
  end
end
