class Diver < ActiveRecord::Base
  
  has_many :diver_samples
  has_many :samples, :through => :diver_samples, :dependent => :destroy

  validates :diver_number, :presence => true
  validates :diver_name, :presence => true


  scope :active_divers,      lambda { where(:active => true) }
end
