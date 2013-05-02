class CoralDemographic < ActiveRecord::Base

  has_many :demographic_corals
  has_many :corals, :through => :demographic_corals
  accepts_nested_attributes_for :demographic_corals, :allow_destroy => true

  belongs_to :diver
  belongs_to :habitat_type
  belongs_to :boatlog_manager

  def myId
    return self.diver_id
  end


end
