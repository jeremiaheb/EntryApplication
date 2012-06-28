class SampleAnimal < ActiveRecord::Base
  belongs_to :sample
  belongs_to :animal
end
