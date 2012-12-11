class SampleAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sample

  def get_common
    Animal.find(self.animal_id).common_name
  end
  
  def time_seen2
    Animal.find(self.animal.id).common_name
  end


  validates :number_individuals,       :presence => :true
#  validates :average_length,       :presence => :true
#  validates :min_length,       :presence => :true
#  validates :max_length,       :presence => :true
end
