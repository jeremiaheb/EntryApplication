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

  #def self.to_csv(options = {})
    #CSV.generate(options) do |csv|
      #csv << column_names
      #all.each do |boatlog|
        #csv << boatlog.attributes.values_at(*column_names)
      #end
    #end
  #end
end
