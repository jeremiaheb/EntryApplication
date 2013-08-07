class StationLog < ActiveRecord::Base
  
  belongs_to :boat_log
  has_many :rep_logs, :dependent => :destroy
  accepts_nested_attributes_for :rep_logs, :reject_if => lambda {  |a| a[:replicate].blank? }, :allow_destroy => true

  def psu
    return self.boat_log.primary_sample_unit
  end

end
