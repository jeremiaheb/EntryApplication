class Animal < ActiveRecord::Base
  has_many :sample_animals
  has_many :samples, :through => :sample_animals, :dependent => :destroy
end
