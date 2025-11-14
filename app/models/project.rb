class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :missions, dependent: :restrict_with_error
end
