class Region < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :region_habitat_types, dependent: :destroy
  has_many :habitat_types, through: :region_habitat_types
end
