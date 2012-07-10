class HabitatType < ActiveRecord::Base
  has_many :samples

  validates :habitat_name, :presence => true
  validates :habitat_description, :presence => true

end
