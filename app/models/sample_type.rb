class SampleType < ActiveRecord::Base
  attr_protected []
  has_many :samples

  validates :sample_type_name, :presence => true
  validates :sample_type_description, :presence => true

end
