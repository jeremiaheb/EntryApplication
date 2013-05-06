class InvertBelt < ActiveRecord::Base
  belongs_to :benthic_cover



  validates :lobster_num,     :presence => true
  validates :conch_num,       :presence => true
  validates :diadema_num,     :presence => true
end
