class DiverSample < ActiveRecord::Base
  belongs_to :diver
  belongs_to :sample


  scope :primary, lambda { where(primary_diver: true) }
end
