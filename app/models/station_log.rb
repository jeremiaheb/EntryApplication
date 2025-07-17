class StationLog < ActiveRecord::Base
  belongs_to :boat_log
  has_many :rep_logs, dependent: :destroy
  accepts_nested_attributes_for :rep_logs, allow_destroy: true

  validates :stn_number,        presence: true, length: { is: 1 }, numericality: { only_integer: true }
  validates :time,              presence: true
  validates :latitude,          presence: true, numericality: { greater_than: 0, message: "must be positive (northern hemisphere)" }
  validates :longitude,         presence: true, numericality: { less_than: 0, message: "must be negative (western hemisphere)" }

  def psu
    self.boat_log.primary_sample_unit
  end

  def latitude_in_northern_degrees
    latitude
  end

  def latitude_in_northern_degrees=(northern_degrees)
    self.latitude = northern_degrees.presence&.to_f
  end

  def longitude_in_western_degrees
    -longitude if longitude
  end

  def longitude_in_western_degrees=(western_degrees)
    # 123.send(:-@) is equivalent to -123 (i.e., it negates the number)
    self.longitude = western_degrees.presence&.to_f&.send(:-@)
  end
end
