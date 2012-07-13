class Sample < ActiveRecord::Base
  belongs_to :sample_type
  belongs_to :habitat_type

  has_many :sample_animals
  has_many :animals, :through => :sample_animals, :dependent => :destroy
  accepts_nested_attributes_for :sample_animals, :allow_destroy => true

  has_many :diver_samples
  has_many :divers, :through => :diver_samples, :dependent => :destroy
  accepts_nested_attributes_for :diver_samples, :allow_destroy => true

  validates :sample_date,                 :presence => true 
  validates :sample_type_id,              :presence => true
  validates :habitat_type_id,             :presence => true

  validates :dive_begin_time,             :presence => true
  validates :dive_end_time,               :presence => true
  validates :sample_begin_time,           :presence => true
  validates :sample_end_time,             :presence => true


  validates :dive_depth,                  :presence => true
  validates :sample_depth,                :presence => true          
  validates :field_id,                    :presence => true
  validates_format_of :field_id,          :with => /\d\d\d\d[A-Z]/
  validates :underwater_visibility,       :presence => true
  validates :fishing_gear,                :length => { :maximum => 50 }
  validates :sample_description,          :length => { :maximum => 150 }                    

  validate :sample_start_before_sample_end

  def sample_start_before_sample_end
    errors.add(:sample_begin_time, "must be before end time") unless
      self.sample_begin_time < self.sample_end_time
  end

before_save :default_values

def default_values
  self.hard_relief_cat_0 ||= 0
end


end
