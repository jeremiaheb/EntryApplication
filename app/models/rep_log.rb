class RepLog < ActiveRecord::Base
  
  belongs_to :boat_log
  belongs_to :station_log
  belongs_to :diver

end
