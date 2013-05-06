class Coral < ActiveRecord::Base

  has_many :demographic_corals
  has_many :coral_demographics, :through => :demographic_corals
  accepts_nested_attributes_for :demographic_corals, :allow_destroy => true

end
