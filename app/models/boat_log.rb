class BoatLog < ActiveRecord::Base

  has_many :station_logs, :dependent => :destroy
  has_many :rep_logs, :through => :station_logs
  accepts_nested_attributes_for :station_logs, :allow_destroy => true

end
