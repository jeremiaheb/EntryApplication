class PossibleDuplicateReport
  def initialize(boatlog_managers)
    @boatlog_managers = boatlog_managers
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
    BoatLog.where(boatlog_manager_id: @boatlog_managers).includes(:boatlog_manager)
  end

  def samples
    Sample.where(boatlog_manager_id: @boatlog_managers).includes(:diver) +
      BenthicCover.where(boatlog_manager_id: @boatlog_managers).includes(:diver) +
      CoralDemographic.where(boatlog_manager_id: @boatlog_managers).includes(:diver)
  end
end
