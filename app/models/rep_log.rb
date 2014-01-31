class RepLog < ActiveRecord::Base
  
  belongs_to  :station_log

  belongs_to  :diver

  def field_id
    return [self.station_log.psu,self.station_log.stn_number, self.replicate.upcase ].join("")
  end

  def replicate=(value)
    write_attribute(:replicate, value.upcase)
  end

end
