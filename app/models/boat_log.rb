class BoatLog < ApplicationRecord
  belongs_to :boatlog_manager, optional: true # TODO: Remove boatlog_manager relation

  has_many :station_logs, dependent: :destroy
  has_many :rep_logs, through: :station_logs
  has_many :divers, through: :rep_logs
  accepts_nested_attributes_for :station_logs, allow_destroy: true

  belongs_to :mission, optional: true # TODO: Remove optional
  has_one :region, through: :mission
  has_one :agency, through: :mission
  has_one :project, through: :mission

  validates :mission_id,          presence: true
  validates :primary_sample_unit, presence: true, length: { is: 4 }
  validates :date,                presence: true

  def boatlog_divers
    boatlog_divers_list = []
    rep_logs.includes([:diver]).each do |rep|
      boatlog_divers_list << [date, rep.field_id, rep.diver.diver_name]
    end
    boatlog_divers_list.sort_by { |e| e[0] }
  end
end
