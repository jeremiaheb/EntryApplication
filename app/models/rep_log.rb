class RepLog < ActiveRecord::Base
  belongs_to  :station_log
  belongs_to  :diver

  validates :replicate,               :presence => true
  validates_format_of :replicate,     :with => /[a-zA-Z]/, :message => "Not one of Valid Letters"

  def field_id
    return [self.station_log.boat_log.primary_sample_unit,self.station_log.stn_number, self.replicate.upcase ].join("")
  end

  def replicate=(value)
    write_attribute(:replicate, value.upcase)
  end
end
