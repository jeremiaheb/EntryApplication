class Cleanup
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :region_ids, array: true, default: -> { [] }
  attribute :agency_ids, array: true, default: -> { [] }
  attribute :project_ids, array: true, default: -> { [] }

  validate :at_least_one_attribute_specified

  def region_ids=(region_ids)
    super(region_ids.reject(&:blank?))
  end

  def agency_ids=(agency_ids)
    super(agency_ids.reject(&:blank?))
  end

  def project_ids=(project_ids)
    super(project_ids.reject(&:blank?))
  end

  def at_least_one_attribute_specified
    if region_ids.blank? && agency_ids.blank? && project_ids.blank?
      errors.add(:base, "at least one parameter (region, agency or project) must be specified")
    end
  end

  def backup_and_cleanup!
    DatabaseDumper.new.dump_to_destinations

    mission_query = {
      region_id: region_ids,
      agency_id: agency_ids,
      project_id: project_ids,
    }.reject { |_, v| v.empty? }
    return if mission_query.empty?

    ActiveRecord::Base.transaction do
      [Sample, BenthicCover, CoralDemographic, BoatLog].each do |model|
        model.joins(:mission).where(mission: mission_query).destroy_all
      end
    end
  end
end
