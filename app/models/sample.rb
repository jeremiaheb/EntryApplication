class Sample < ActiveRecord::Base
  belongs_to :sample_type
  belongs_to :habitat_type

  has_many :sample_animals
  has_many :animals, :through => :sample_animals, :dependent => :destroy
  accepts_nested_attributes_for :sample_animals, :allow_destroy => true

  has_many :diver_samples
  has_many :divers, :through => :diver_samples, :dependent => :destroy
  accepts_nested_attributes_for :diver_samples, :allow_destroy => true

  validates :sample_date,       :presence => true 
  validates :sample_type_id,    :presence => true
  validates :habitat_type_id,   :presence => true

  validates :dive_begin_time,   :presence => true
  validates :dive_end_time,     :presence => true
  validates :sample_begin_time, :presence => true
  validates :sample_end_time,   :presence => true

end
