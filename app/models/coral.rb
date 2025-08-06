class Coral < ApplicationRecord
  has_many :demographic_corals, dependent: :restrict_with_error
  has_many :coral_demographics, through: :demographic_corals

  validates :short_code, presence: true
  validates :code, presence: true
  validates :scientific_name, presence: true

  def display_name
    [self.short_code, self.code, self.scientific_name].join(" __ ")
  end
end
