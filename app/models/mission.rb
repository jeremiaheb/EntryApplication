class Mission < ActiveRecord::Base
  belongs_to :project
  validates :project_id, uniqueness: { scope: [:agency_id, :region_id] }

  belongs_to :agency

  belongs_to :region

  has_many :mission_managers, dependent: :destroy
  has_many :managers, through: :mission_managers, class_name: "Diver"

  validates :active, inclusion: [true, false]

  scope :standard_order, -> { joins(:agency, :project).order(:"agencies.name", :"projects.name", :id) }
  scope :active, -> { where(active: true) }
end
