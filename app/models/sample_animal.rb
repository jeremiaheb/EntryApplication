class SampleAnimal < ActiveRecord::Base
  belongs_to :animal
  belongs_to :sample
end
