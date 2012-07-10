class Animal < ActiveRecord::Base
  has_many :sample_animals
  has_many :samples, :through => :sample_animals, :dependent => :destroy

  validates :species_code,    :presence => true
  validates :scientific_name, :presence => true
  validates :common_name,     :presence => true
  validates :max_size,        :presence => true
  validates :min_size,        :presence => true
  validates :max_number,      :presence => true

end
