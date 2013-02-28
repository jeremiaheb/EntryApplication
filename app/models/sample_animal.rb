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

  validates :number_individuals,          :presence => :true
  #validates_presence_of :average_length,  :if => :has_ind_equal_1?
  #validates_presence_of :min_length,      :if => :has_ind_equal_2?
  #validates_presence_of :max_length,      :if => :has_ind_equal_2?
  #validates :average_length,              :presence => true, :if => :has_ind_equal_1?


  def has_ind_equal_1?
    if self.number_individuals == 1
      true
    else if self.number_individuals >= 3
      true
    else
      false
    end
    end
  end
  
  def has_ind_equal_2?
    if self.number_individuals >= 2
      true
    else
      false
    end
  end

#  validate :validate_min_mean_max
#
#
#
#  def validate_min_mean_max
#    n = self.number_individuals
#    case n
#      when 1
#        validates :average_length, :presence => true
#      when 2
#        validates :min_length, :presence => true
#        validates :max_length, :presence => true
#        if self.max_length < self.min_length
#          errors.add(:max_length, "Max length cannot be less than min length")
#        end
#      when n >= 3
#        validates :average_length, :presence => true
#        validates :min_length, :presence => true
#        validates :max_length, :presence => true
#        if self.max_length < self.min_length
#          errors.add(:max_length, "Max length cannot be less than min length")
#        else if self.average_length < self.min_length
#          errors.add(:min_length, "Min length cannot be greater than mean length")
#        end
#      end
#    end
#  end


end
