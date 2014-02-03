class Animal < ActiveRecord::Base
  has_many :sample_animals, :dependent => :destroy
  has_many :samples, :through => :sample_animals
  accepts_nested_attributes_for :sample_animals, :allow_destroy => true

  validates :species_code,    :presence => true
  validates :scientific_name, :presence => true
  validates :common_name,     :presence => true
  validates :max_size,        :presence => true
  validates :min_size,        :presence => true
  validates :max_number,      :presence => true

  def spp_code_common
    "#{species_code} __ #{common_name}"
  end


end
