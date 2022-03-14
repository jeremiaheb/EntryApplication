class Animal < ActiveRecord::Base
  
  attr_protected []

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

  # Name to use when generating report
  def report_name(name_type)
    case name_type
    when "common_name"
      common_name
    else
      species_code
    end
  end

end
