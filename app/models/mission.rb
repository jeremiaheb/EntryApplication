class Mission < ActiveRecord::Base
  belongs_to :project
  validates :project_id, presence: true, uniqueness: { scope: [:agency_id, :jurisdiction_id] }

  belongs_to :agency

  belongs_to :jurisdiction

  has_many :mission_managers, dependent: :destroy
  has_many :managers, through: :mission_managers, class_name: "Diver"

  scope :standard_order, -> { joins(:jurisdiction, :agency, :project).order(:"jurisdictions.id", :"agencies.id", :"projects.id", :id) }

  def display_name
    [jurisdiction.name, agency.name, project.name].join(" ▸ ")
  end
end
