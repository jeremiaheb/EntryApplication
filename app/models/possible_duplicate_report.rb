class PossibleDuplicateReport
  def initialize(missions)
    @missions = missions
  end

  def duplicate_boat_logs_by_primary_sample_unit
    boat_logs.sort_by(&:primary_sample_unit)
      .group_by(&:primary_sample_unit)
      .select { |psu, boat_logs|
        boat_logs.length > 1
      }
  end

  def duplicate_samples_by_field_id
    samples.sort_by(&:field_id)
      .group_by(&:field_id)
      .select { |field_id, samples|
        samples.length > 1
      }
  end

  private

  def boat_logs
    BoatLog.where(mission_id: @missions).includes(:mission)
  end

  def samples
    Sample.where(mission_id: @missions).includes(:diver) +
      BenthicCover.where(mission_id: @missions).includes(:diver) +
      CoralDemographic.where(mission_id: @missions).includes(:diver)
  end
end
