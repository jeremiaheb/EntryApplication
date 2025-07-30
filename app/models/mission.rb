class Mission < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true, uniqueness: { scope: [:agency_id, :region_id] }

  belongs_to :agency

  belongs_to :region

  has_many :mission_managers, dependent: :destroy
  has_many :managers, through: :mission_managers, class_name: "Diver"

  scope :standard_order, -> { joins(:agency, :project).order(:"agencies.name", :"projects.name", :id) }
end
