class BoatLog < ActiveRecord::Base
    
  belongs_to :boatlog_manager

  has_many :station_logs, :dependent => :destroy
  has_many :rep_logs, :through => :station_logs
  accepts_nested_attributes_for :station_logs, :reject_if => lambda {  |a| a[:stn_number].blank? }, :allow_destroy => true



  def boatlog_divers
    boatlog_divers_list = []
    rep_logs.each do |rep|

      boatlog_divers_list << [rep.field_id, rep.diver.diver_name ]
    end
    boatlog_divers_list.sort_by { |e| e[0] }
  end

  validates :primary_sample_unit, :presence => true

end
