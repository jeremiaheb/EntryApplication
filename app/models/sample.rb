class Sample < ActiveRecord::Base
  belongs_to :sample_type
  belongs_to :habitat_type

  has_many :sample_animals
  has_many :animals, :through => :sample_animals
  accepts_nested_attributes_for :sample_animals

  has_many :sample_divers
  has_many :divers, :through => :sample_divers
  accepts_nested_attributes_for :sample_divers

end
