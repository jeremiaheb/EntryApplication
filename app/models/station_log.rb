class StationLog < ActiveRecord::Base
  
  belongs_to :boat_log
  has_many :rep_logs, :dependent => :destroy
  accepts_nested_attributes_for :rep_logs, :reject_if => lambda {  |a| a[:replicate].blank? }, :allow_destroy => true


  validates :stn_number, :presence => true

  #validate :stations_less_than_50m

  EARTH_RADIUS = 6371000 # Earth's radius in meters

  # convert degrees to radians
  def convDegRad(value)
    unless value.nil? or value == 0
          value = (value/180) * Math::PI
    end
  return value
  end

  def coorDist

    stn1_coordinates = [ self.where(stn_number: 1).first.latitude, self.where(stn_number: 1).first.longitude ]
    stn2_coordinates = [ self.where(stn_number: 2).first.latitude, self.where(stn_number: 2).first.longitude ]
    

    deltaLat = (stn2_coordinates[0] - stn1_coordinates[0])
    deltaLon = (stn2_coordinates[1] - stn1_coordinates[1])
    deltaLat = convDegRad(deltaLat)
    deltaLon = convDegRad(deltaLon)

    # Calculate square of half the chord length between latitude and longitude
    a = Math.sin(deltaLat/2) * Math.sin(deltaLat/2) +
        Math.cos((stn1_coordinates[0]/180 * Math::PI)) * Math.cos((stn2_coordinates[0]/180 * Math::PI)) *
        Math.sin(deltaLon/2) * Math.sin(deltaLon/2); 

    # Calculate the angular distance in radians
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    distance = EARTH_RADIUS * c

    return distance

  end

  private

  def stations_less_than_50m
    if coorDist > 50
      self.errors.add :comments, ' Stations are greater than 50m apart '
    end
  end

end
