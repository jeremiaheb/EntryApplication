class StationLog < ActiveRecord::Base
  belongs_to :boat_log
  has_many :rep_logs, :dependent => :destroy
  accepts_nested_attributes_for :rep_logs, :reject_if => lambda {  |a| a[:replicate].blank? }, :allow_destroy => true

  validates :stn_number,        :presence => true, :length => { :is => 1 }, :numericality => { :only_integer => true }
  validates :time,              :presence => true
  validates :latitude,          :presence => true, :numericality => true
  validates :longitude,         :presence => true, :numericality => true

  def psu
    return self.boat_log.primary_sample_unit
  end
end
