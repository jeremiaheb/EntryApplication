class Sample < ActiveRecord::Base
  belongs_to :sample_type
  belongs_to :habitat_type
  belongs_to :boatlog_manager

  has_many :sample_animals, :dependent => :destroy
  validates_presence_of :sample_animals, :message => "you must have at leat one species record (can be NO FISH)"
  has_many :animals, :through => :sample_animals
  accepts_nested_attributes_for :sample_animals, :reject_if => lambda {  |a| a[:animal_id].blank? }, :allow_destroy => true
  

  has_many :diver_samples, :dependent => :destroy
  has_many :divers, :through => :diver_samples
  accepts_nested_attributes_for :diver_samples, :allow_destroy => true



  def myId
    return self.diver_samples.primary.first.diver_id
  end

  #validates :sample_date,                 :presence => true 
  validates :sample_type_id,              :presence => true
  validates :habitat_type_id,             :presence => true

  validates :dive_begin_time,             :presence => true
  validates :dive_end_time,               :presence => true
  validate  :dive_starts_before_ends
  validates :sample_begin_time,           :presence => true
  validate  :sample_starts_after_dive_and_before_end
  validates :sample_end_time,             :presence => true
  validate  :sample_ends_before_dive_ends
  validate  :sample_starts_before_ends

  validates :field_id,                    :presence => true
  validates_format_of :field_id,          :with => /...\d[a-zA-Z]/
  validates :dive_depth,                  :presence => true, :numericality => true
  validates :sample_depth,                :presence => true, :numericality => true          
  validates :underwater_visibility,       :presence => true, :numericality => true
  validates :water_temp,                  :presence => true, :numericality => true
  validates :sample_description,          :length => { :maximum => 150 }                    

  validates :substrate_max_depth,         :presence => true, :numericality => { :only_integer => true }
  validates :substrate_min_depth,         :presence => true, :numericality => { :only_integer => true, :less_than_or_equal_to => :substrate_max_depth }

  validates :hard_verticle_relief,         :presence => true, :numericality => true
  validates :soft_verticle_relief,         :presence => true, :numericality => true

  validates :hard_relief_cat_0,           :presence => true, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :hard_relief_cat_1,           :presence => true, :if => "hard_verticle_relief > 0.2", :numericality => { :only_integer => true, :greater_than => 0 }
  validates :hard_relief_cat_2,           :presence => true, :if => "hard_verticle_relief > 0.5", :numericality => { :only_integer => true, :greater_than => 0 }
  validates :hard_relief_cat_3,           :presence => true, :if => "hard_verticle_relief > 1.0", :numericality => { :only_integer => true, :greater_than => 0 }
  validates :hard_relief_cat_4,           :presence => true, :if => "hard_verticle_relief > 1.5", :numericality => { :only_integer => true, :greater_than => 0 }

  validate :hard_relief_cats_equal_100
  validate :soft_relief_cats_equal_100
  validate :abiotic_percentage_equal_100
  validate :biotic_percentage_sand_equal_100, :if => :sand_percentage?
  validate :biotic_percentage_hardbottom_equal_100, :if => :hardbottom_percentage?


  def field_id=(value)
    write_attribute(:field_id, value.upcase)
  end
 
  def msn
    return [ self.sample_date.strftime('%Y%m%d'), self.sample_begin_time.strftime('%H%M'), self.diver_samples.primary[0].diver.diver_number ].join('')
  end

   private


  def sample_starts_before_ends
    if self.sample_begin_time >= self.sample_end_time
      self.errors.add :sample_end_time, ' has to end after begin time '
    end
  end

  def dive_starts_before_ends
    if self.dive_begin_time >= self.dive_end_time
      self.errors.add :dive_end_time, ' has to end after begin time '
    end
  end

  def sample_starts_after_dive_and_before_end
    if self.sample_begin_time <= self.dive_begin_time || self.sample_begin_time > self.dive_end_time
      self.errors.add :sample_begin_time, "Sample start time has to be after dive start or before dive end"
    end
  end

  def sample_ends_before_dive_ends
    if self.sample_end_time > self.dive_end_time
      self.errors.add :sample_end_time, "Sample end time has to be before dive end time"
    end
  end

  def hard_relief_cats_equal_100
      values = []
      [self.hard_relief_cat_0, self.hard_relief_cat_1, self.hard_relief_cat_2, self.hard_relief_cat_3, self.hard_relief_cat_4 ].each do |cat|
        if !cat.nil?
          values.push(cat)
        end
      end
      values.delete_if { |x| x == nil }
      if (values.sum) != 100
        errors.add( :base, "hard relief categories do not add to 100" )
      end
  end

  def soft_relief_cats_equal_100
      values = []
      [self.soft_relief_cat_0, self.soft_relief_cat_1, self.soft_relief_cat_2, self.soft_relief_cat_3, self.soft_relief_cat_4 ].each do |cat|
        if !cat.nil?
          values.push(cat)
        end
      end
      values.delete_if { |x| x == nil }
      if (values.sum) != 100
        errors.add( :base, "soft relief categories do not add to 100" )
      end
  end

  def abiotic_percentage_equal_100
      values = []
      [ self.sand_percentage, self.hardbottom_percentage, rubble_percentage ].each do |cat|
        if !cat.nil?
          values.push(cat)
        end
      end
      values.delete_if { |x| x == nil }
      if (values.sum) != 100
        errors.add( :base, "abiotic percentages do not add to 100" )
      end
  end

  def biotic_percentage_sand_equal_100
      values = []
      [ self.sand_bare, self.sand_macro_algae, self.sand_seagrass, self.sand_sponge, self.sand_pcov_other1, self.sand_pcov_other2 ].each do |cat|
        if !cat.nil?
          values.push(cat)
        end
      end
      values.delete_if { |x| x == nil }
      if (values.sum) != 100
        errors.add( :base, "Sand biotic percentages do not add to 100" )
      end
  end

  def biotic_percentage_hardbottom_equal_100
      values = []
      [ self.hardbottom_algal_turf, self.hardbottom_macro_algae, self.hardbottom_live_coral, self.hardbottom_octocoral, self.hardbottom_sponge, self.hard_pcov_other1, self.hard_pcov_other2 ].each do |cat|
        if !cat.nil?
          values.push(cat)
        end
      end
      values.delete_if { |x| x == nil }
      if (values.sum) != 100
        errors.add( :base, "Hardbottom biotic percentages do not add to 100" )
      end
  end

  #def self.to_csv(options = {})
    #CSV.generate(options) do |csv|
      #csv << column_names
      #all.each do |sample|
        #csv << sample.attributes.values_at(*column_names)
      #end
    #end
  #end


end
