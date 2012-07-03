class Diver < ActiveRecord::Base
  
  has_many :diver_samples
  has_many :samples, :through => :diver_samples, :dependent => :destroy
end
