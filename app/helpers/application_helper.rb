module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "info"
    when :error then "error"
    when :alert then "warning"
    end
  end

  # Returns a list of regions, extracted from active missions and the current
  # mission (if no longer active).
  def region_options_for_select(current_mission:)
    regions = (Mission.active.includes(:region) + [current_mission]).
      compact.
      map(&:region).
      uniq.
      sort_by(&:name)

    regions.map { |region|
      [
        region.name,
        region.id,
      ]
    }
  end

  # Returns a list of missions, comprising all active missions and the current
  # mission (if no longer active).
  #
  # Each option will have a data-region-id attribute specifying the region for
  # the given mission. This can be used to toggle available options when the
  # region is selected.
  def mission_options_for_select(current_mission:)
    missions = (Mission.active.includes(:region, :agency, :project) + [current_mission]).
      compact.
      uniq.
      sort_by(&:display_name)

    missions.map { |mission|
      [
         mission.display_name,
         mission.id,
         "data-region-id": mission.region_id,
      ]
    }
  end

  # Returns a list of habitat types appropriate for passing to
  # options_for_select.
  #
  # Each option will have a data-region-ids attribute with a JSON array of
  # region IDs where the habitat type is valid.
  #
  # An option will be initially disabled unless the current_region_id is in the
  # list of valid region IDs for the given habitat type.
  def habitat_type_options_for_select(current_region_id:)
    HabitatType.includes(:regions).order(:habitat_name).map { |habitat_type|
      [
        habitat_type.habitat_name,
        habitat_type.id,
        "data-region-ids": habitat_type.region_ids.to_json,
        "disabled": !habitat_type.region_ids.include?(current_region_id),
      ]
    }
  end
end
