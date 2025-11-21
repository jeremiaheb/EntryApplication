class Region < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :region_habitat_types, dependent: :destroy
  has_many :habitat_types, through: :region_habitat_types
  has_many :missions, dependent: :restrict_with_error
end
