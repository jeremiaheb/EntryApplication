class BoatLog < ActiveRecord::Base

  has_many :station_logs, :dependent => :destroy
  has_many :rep_logs, :through => :station_logs
  accepts_nested_attributes_for :station_logs, :reject_if => lambda {  |a| a[:stn_number].blank? }, :allow_destroy => true


  validates :primary_sample_unit, :presence => true

end
