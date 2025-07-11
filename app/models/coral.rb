class Coral < ActiveRecord::Base
  has_many :demographic_corals
  has_many :coral_demographics, :through => :demographic_corals
  accepts_nested_attributes_for :demographic_corals, :allow_destroy => true

  validates :short_code, presence: true
  validates :code, presence: true
  validates :scientific_name, presence: true

  def display_name
    [self.short_code, self.code, self.scientific_name].join(" __ ")
  end
end
