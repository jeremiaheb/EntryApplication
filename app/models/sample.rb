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
    self.hard_relief_cat_0        ||= 0
    self.hard_relief_cat_1        ||= 0
    self.hard_relief_cat_2        ||= 0
    self.hard_relief_cat_3        ||= 0
    self.hard_relief_cat_4        ||= 0
    self.soft_relief_cat_0        ||= 0
    self.soft_relief_cat_1        ||= 0
    self.soft_relief_cat_2        ||= 0
    self.soft_relief_cat_3        ||= 0
    self.soft_relief_cat_4        ||= 0
    self.sand_percentage          ||= 0
    self.hardbottom_percentage    ||= 0
    self.rubble_percentage        ||= 0
    self.sand_bare                ||= 0
    self.sand_macro_algae         ||= 0
    self.sand_seagrass            ||= 0
    self.sand_sponge              ||= 0
    self.sand_pcov_other1         ||= 0
    self.sand_pcov_other2         ||= 0
    self.hardbottom_algal_turf    ||= 0
    self.hardbottom_macro_algae   ||= 0
    self.hardbottom_live_coral    ||= 0
    self.hardbottom_octocoral     ||= 0
    self.hardbottom_sponge        ||= 0
    self.hard_pcov_other1         ||= 0
    self.hard_pcov_other2         ||= 0
  
  end


end
