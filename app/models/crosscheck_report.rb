# CrosscheckReport is used on the manager dashboard to find:
# - Missing/non-existent samples based on boat logs that do exist
# - Missing/non-existent boat logs based on samples that do exist
class CrosscheckReport
  # MissingEntry represents an entry (sample or boat log) that is potentially
  # missing/non-existent based on the existence of a related model.
  #
  # For a MissingEntry representing a sample, the related_model will be a boat log.
  # For a MissingEntry representing a boat log, the related_model will be a sample.
  class MissingEntry
    attr_reader :diver, :date, :field_id, :related_model

    def initialize(diver, date, field_id, related_model)
      @diver = diver
      @date = date
      @field_id = field_id
      @related_model = related_model
    end

    # eql? is true if the diver, date and field ID match. The related_model is
    # NOT considered because it is used only to link a user to the related
    # model.
    def eql?(other)
      return false unless other.is_a?(MissingEntry)

      diver == other.diver &&
        date == other.date &&
        field_id == other.field_id
    end
    alias == eql?

    def hash
      [diver, date, field_id].hash
    end
  end

  def initialize(boatlog_managers)
    @boatlog_managers = boatlog_managers
  end

  def missing_samples_from_diver
    all_boat_log_replicates_as_missing_entries - all_samples_as_missing_entries
  end

  def missing_samples_from_boat_log
    all_samples_as_missing_entries - all_boat_log_replicates_as_missing_entries
  end

  private

  def all_samples_as_missing_entries
    # Memoize to avoid running expensive queries multiple times
    return @all_samples_as_missing_samples if defined?(@all_samples_as_missing_samples)

    @all_samples_as_missing_samples = (samples + benthic_covers + coral_demographics).map { |sample|
      MissingEntry.new(sample.diver, sample.sample_date, sample.field_id, sample)
    }.sort_by(&:date)
  end

  def all_boat_log_replicates_as_missing_entries
    # Memoize to avoid running expensive queries multiple times
    return @all_boat_log_replicates_as_missing_samples if defined?(@all_boat_log_replicates_as_missing_samples)

    @all_boat_log_replicates_as_missing_samples = boat_log_replicates.map { |rep_log|
      MissingEntry.new(rep_log.diver, rep_log.station_log.boat_log.date, rep_log.field_id, rep_log.station_log.boat_log)
    }.sort_by(&:date)
  end

  def boat_log_replicates
    RepLog.joins(station_log: :boat_log).where("boat_logs.boatlog_manager_id": @boatlog_managers).includes({ station_log: :boat_log }, :diver)
  end

  def samples
    Sample.where(boatlog_manager_id: @boatlog_managers).includes(:diver)
  end

  def benthic_covers
    BenthicCover.where(boatlog_manager_id: @boatlog_managers).includes(:diver)
  end

  def coral_demographics
    CoralDemographic.where(boatlog_manager_id: @boatlog_managers).includes(:diver)
  end
end
