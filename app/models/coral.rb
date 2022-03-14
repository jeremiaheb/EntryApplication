class Coral < ActiveRecord::Base

  attr_protected []
  has_many :demographic_corals
  has_many :coral_demographics, :through => :demographic_corals
  accepts_nested_attributes_for :demographic_corals, :allow_destroy => true

  validates :code,                :presence => true
  validates :scientific_name,     :presence => true

  def coral_code_name
    [self.code, self.scientific_name].join(" __ ")
  end
  

end
