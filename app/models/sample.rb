class Sample < ActiveRecord::Base
  belongs_to :sample_type
  belongs_to :habitat_type

  has_many :sample_animals
  has_many :animals, :through => :sample_animals, :dependent => :destroy
  accepts_nested_attributes_for :sample_animals, :allow_destroy => true

  has_many :sample_divers
  has_many :divers, :through => :sample_divers, :dependent => :destroy
  accepts_nested_attributes_for :sample_divers, :allow_destroy => true

end
