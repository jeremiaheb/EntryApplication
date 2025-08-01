class SampleType < ActiveRecord::Base
  has_many :samples

  validates :sample_type_name, presence: true
  validates :sample_type_description, presence: true

  # Returns the default (most likely to be used) sample type, if it exists
  def self.default
    SampleType.where(sample_type_name: "Bohn-Bannerot Point").first
  end
end
