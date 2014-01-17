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

  #validate :abiotic_percentage_equal_100


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

end
