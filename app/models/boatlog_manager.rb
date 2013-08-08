class BoatlogManager < ActiveRecord::Base
  has_many  :samples
  has_one   :diver
  has_many  :benthic_covers
  has_many  :coral_demographics
  has_many  :boat_logs

  def agency_name
    [self.agency, self.lastname].join('/')
  end

  validates :agency,        :presence => true
  validates :firstname,     :presence => true
  validates :lastname,      :presence => true


end
