# SampleCountReport creates a matrix of sample counts per diver that a boatlog
# manager is responsible for.
#
# It is used to populate a table on the manager dashboard.
class SampleCountReport
  def initialize(boatlog_managers)
    @boatlog_managers = boatlog_managers
  end

  def counts_by_diver
    # Memoize to avoid running expensive queries multiple times
    return @counts_by_diver if defined?(@counts_by_diver)

    ret = Hash.new { |h, k|
      h[k] = {
        "boat" => 0,
        "sample" => 0,
        "lpi" => 0,
        "demo" => 0,
      }
    }

    boat_log_replicates.each do |rep_log|
      ret[rep_log.diver]["boat"] += 1
    end

    samples.each do |sample|
      ret[sample.diver]["sample"] += 1
    end

    benthic_covers.each do |benthic_cover|
      ret[benthic_cover.diver]["lpi"] += 1
    end

    coral_demographics.each do |coral_demographic|
      ret[coral_demographic.diver]["demo"] += 1
    end

    @counts_by_diver = ret.sort_by { |diver, _| diver.diver_name }.to_h
  end

  private

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
