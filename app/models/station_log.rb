class StationLog < ActiveRecord::Base
  
  belongs_to :boat_log
  has_many :rep_logs, :dependent => :destroy
  accepts_nested_attributes_for :rep_logs, :allow_destroy => true

end
