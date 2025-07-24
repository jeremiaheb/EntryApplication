class Jurisdiction < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :jurisdiction_habitat_types, dependent: :destroy
  has_many :habitat_types, through: :jurisdiction_habitat_types
end
