class SampleAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sample

  def get_common
    Animal.find(self.animal_id).common_name
  end
  
  def time_seen2
    Animal.find(self.animal.id).common_name
  end

  default_scope :order => "id ASC"

  validates :number_individuals,       :presence => :true
#  validates :average_length,       :presence => :true
#  validates :min_length,       :presence => :true
#  validates :max_length,       :presence => :true

  validate :validate_min_mean


  private

  def validate_min_mean
    if  self.average_length < self.min_length
      errors.add(:min_length, "Min length cannot be greater than mean length")
    end
  end


end
