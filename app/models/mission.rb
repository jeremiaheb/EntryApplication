class Mission < ActiveRecord::Base
  belongs_to :region
  attr_readonly :region_id

  belongs_to :agency
  attr_readonly :agency_id

  belongs_to :project
  validates :project_id, uniqueness: { scope: [:agency_id, :region_id], message: "must be unique for each region and agency. Please edit the existing mission instead." }
  attr_readonly :project_id

  has_many :mission_managers, dependent: :destroy
  has_many :managers, through: :mission_managers, class_name: "Diver"

  has_many :samples, dependent: :restrict_with_error

  validates :active, inclusion: [true, false]

  scope :standard_order, -> { joins(:region, :agency, :project).order(:"regions.name", :"agencies.name", :"projects.name", :id) }
  scope :active, -> { where(active: true) }

  def display_name
    [agency.name, project.name].join(" ▸ ")
  end
end
