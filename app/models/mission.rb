class Mission < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true, uniqueness: { scope: [:agency_id, :region_id] }

  belongs_to :agency

  belongs_to :region

  has_many :mission_managers, dependent: :destroy
  has_many :managers, through: :mission_managers, class_name: "Diver"

  scope :standard_order, -> { joins(:region, :agency, :project).order(:"regions.id", :"agencies.id", :"projects.id", :id) }

  def display_name
    [region.name, agency.name, project.name].join(" ▸ ")
  end
end
