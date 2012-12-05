class SampleAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sample

  def get_common
    Animal.find(self.animal_id).common_name
  end
  
  validates :number_individuals,       :presence => :true
end
