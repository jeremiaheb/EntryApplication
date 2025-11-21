class BenthicCover < ApplicationRecord
  include CommonFields

  has_many :point_intercepts, dependent: :destroy
  has_many :cover_cats, through: :point_intercepts
  accepts_nested_attributes_for :point_intercepts, allow_destroy: true

  belongs_to :diver
  belongs_to :buddy, class_name: "Diver"
  belongs_to :habitat_type
  belongs_to :boatlog_manager, optional: true # TODO: Remove boatlog_manager relation

  belongs_to :mission, optional: true # TODO: Remove optional
  has_one :region, through: :mission
  has_one :agency, through: :mission
  has_one :project, through: :mission

  has_one :invert_belt, dependent: :destroy
  accepts_nested_attributes_for :invert_belt, allow_destroy: true
  has_one :presence_belt, dependent: :destroy
  accepts_nested_attributes_for :presence_belt, allow_destroy: true
  has_one :rugosity_measure, dependent: :destroy
  accepts_nested_attributes_for     :rugosity_measure, allow_destroy: true


  validates :mission_id,            presence: true
  validates :diver_id,              presence: true
  validates :buddy_id,              presence: true
  validates :sample_date,           presence: true
  validates :sample_begin_time,     presence: true
  validates :field_id,              presence: true, length: { minimun: 6, maximum: 6 }
  validates_format_of :field_id,    with: /\A\d{5}[a-zA-Z]\z/
  validates :habitat_type,          presence: true
  validates :meters_completed,      presence: true
  validates :sample_description,    length: { maximum: 150 }


  def msn_prefix
    "X"
  end
end
