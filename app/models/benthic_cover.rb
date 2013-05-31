class BenthicCover < ActiveRecord::Base

  has_many :point_intercepts, :dependent => :destroy
  has_many :cover_cats, :through => :point_intercepts
  accepts_nested_attributes_for :point_intercepts, :allow_destroy => true

  belongs_to :diver
  belongs_to :habitat_type
  belongs_to :boatlog_manager

  has_many    :invert_belts, :dependent => :destroy
  accepts_nested_attributes_for     :invert_belts, :allow_destroy => true
  has_many     :presence_belts, :dependent => :destroy
  accepts_nested_attributes_for     :presence_belts, :allow_destroy => true

  def myId
    return self.diver_id
  end

  validates :boatlog_manager_id,    :presence => true
  validates :diver_id,              :presence => true
  validates :buddy,                 :presence => true
  validates :sample_date,           :presence => true
  validates :sample_begin_time,     :presence => true
  validates :field_id,              :presence => true
  validates :habitat_type,          :presence => true
  validates :meters_completed,      :presence => true



  def field_id=(value)
    write_attribute(:field_id, value.upcase)
  end

end
