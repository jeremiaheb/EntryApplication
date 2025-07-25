class CoralDemographic < ActiveRecord::Base
  include CommonFields

  has_many :demographic_corals, dependent: :destroy
  has_many :corals, through: :demographic_corals
  accepts_nested_attributes_for :demographic_corals, allow_destroy: true
  validates_presence_of :demographic_corals, message: "you must have at leat one coral record (can be NO CORAL)"

  belongs_to :diver
  belongs_to :habitat_type
  belongs_to :boatlog_manager


  validates :boatlog_manager_id,    presence: true
  validates :diver_id,              presence: true
  validates :buddy,                 presence: true
  validates :sample_date,           presence: true
  validates :sample_begin_time,     presence: true
  validates :field_id,              presence: true, length: { minimun: 6, maximum: 6 }
  validates_format_of :field_id,    with: /\A\d{5}[a-zA-Z]\z/
  validates :habitat_type,          presence: true
  validates :meters_completed,      presence: true
  validates :percent_hardbottom,    presence: true

  def msn_prefix
    "Y"
  end
end
