class Agency < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :missions, dependent: :restrict_with_error
end
