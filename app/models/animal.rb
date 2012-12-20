class Animal < ActiveRecord::Base
  has_many :sample_animals, :dependent => :destroy
  has_many :samples, :through => :sample_animals
  accepts_nested_attributes_for :sample_animals, :allow_destroy => true

  validates :species_code,    :presence => true
  validates :scientific_name, :presence => true
  validates :common_name,     :presence => true

    
  def spp_code_common
    [self.species_code, self.common_name].join(" __ ")
  end
end
