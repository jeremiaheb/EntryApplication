class BoatlogManager < ActiveRecord::Base
  has_many  :samples
  has_one   :diver
  has_many  :benthic_covers
  has_many  :coral_demographics
  has_many  :boat_logs

  def agency_name
    "#{agency}/#{lastname}"
  end

  validates :agency, :firstname, :lastname, presence: true

  def divers_responsible_for
    boatlog_replicate_divers = boat_logs.includes([:divers]).flat_map(&:divers)
    sample_divers = samples.includes([:diver]).map(&:diver)
    lpi_divers = benthic_covers.includes([:diver]).map(&:diver)
    demo_divers = coral_demographics.includes([:diver]).map(&:diver)
    (boatlog_replicate_divers + sample_divers + lpi_divers + demo_divers).uniq.sort_by(&:diver_name)
  end

  def benthic_covers_for_diver(diver, for_admin = false)
    (for_admin ? BenthicCover : benthic_covers).where(diver_id: diver.id)
  end

  def coral_demographics_for_diver(diver)
    coral_demographics.where(diver_id: diver.id)
  end

  def samples_for_diver(diver)
    samples.where(diver_id: diver.id)
  end

  def boatlog_replicates_for_diver(diver)
    boat_logs.joins(:rep_logs).where("rep_logs.diver_id = ?", diver.id)
  end

  def boatlog_diver_list
    boat_logs.flat_map(&:boatlog_divers)
  end

  def samples_diver_entered
    diver_ids = divers_responsible_for.map(&:id)

    samples = self.samples.includes([:diver]).where(diver_id: diver_ids)
    benthic_covers = self.benthic_covers.includes([:diver]).where(diver_id: diver_ids)
    coral_demographics = self.coral_demographics.includes([:diver]).where(diver_id: diver_ids)

    divers_list = []
    (samples + benthic_covers + coral_demographics).each do |rep|
      divers_list << [rep.sample_date, rep.field_id, rep.diver.diver_name]
    end
    divers_list.sort_by { |e| e[0] }
  end

  def missing_samples_from_diver
    boatlog_diver_list - samples_diver_entered
  end

  def missing_samples_from_boatlog
    samples_diver_entered - boatlog_diver_list
  end
end
