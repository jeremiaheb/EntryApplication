class BoatlogManager < ActiveRecord::Base
  has_many  :samples
  has_one   :diver
  has_many  :benthic_covers
  has_many  :coral_demographics
  has_many  :boat_logs

  def agency_name
    "#{agency}/#{lastname}"
  end

  validates :agency, :firstname, :lastname, :presence => true

  def divers_responsible_for
    boatlog_replicate_divers = boat_logs.map(&:divers).flatten
    sample_divers = samples.joins(:diver_samples).where('diver_samples.primary_diver = ?', true).map { |sample| sample.diver_samples.first.diver }
    lpi_divers = benthic_covers.map { |benthic_cover| benthic_cover.diver }
    demo_divers = coral_demographics.map { |coral_demographic| coral_demographic.diver }
    (boatlog_replicate_divers + sample_divers + lpi_divers + demo_divers).uniq.sort_by(&:diver_name)
  end

  def benthic_covers_for_diver(diver, for_admin = false)
    (for_admin ? BenthicCover : benthic_covers).where(:diver_id => diver.id)
  end

  # TODO: Remove this method and propagate the .count down to the caller. It is
  # a trivial call, and one fewer API to expose and test.
  def benthic_covers_count_for_diver(diver)
    benthic_covers_for_diver(diver).count
  end

  def coral_demographics_for_diver(diver)
    coral_demographics.where(:diver_id => diver.id)
  end

  # TODO: Remove this method and propagate the .count down to the caller. It is
  # a trivial call, and one fewer API to expose and test.
  def coral_demographics_count_for_diver(diver)
    coral_demographics_for_diver(diver).count
  end

  def samples_for_diver(diver)
    samples.joins(:diver_samples).where('diver_samples.primary_diver = ?', true).where('diver_samples.diver_id = ?', diver.id)
  end

  # TODO: Remove this method and propagate the .count down to the caller. It is
  # a trivial call, and one fewer API to expose and test.
  def samples_count_for_diver(diver)
    samples_for_diver(diver).count
  end

  def boatlog_replicates_for_diver(diver)
    boat_logs.joins(:rep_logs).where("rep_logs.diver_id = ?", diver.id)    
  end

  # TODO: Remove this method and propagate the .count down to the caller. It is
  # a trivial call, and one fewer API to expose and test.
  def boatlog_replicates_count_for_diver(diver)
    boatlog_replicates_for_diver(diver).count
  end

  def boatlog_diver_list
    boat_logs.map(&:boatlog_divers).flatten(1)
  end
  
  def samples_diver_entered
    divers_list = []
    divers_responsible_for.map{ |d| samples_for_diver(d) }.flatten(1).each do |rep|

      divers_list << [rep.sample_date, rep.field_id, rep.diver.diver_name ]
    end
    divers_responsible_for.map{ |d| benthic_covers_for_diver(d) }.flatten(1).each do |rep|

      divers_list << [rep.sample_date, rep.field_id, rep.diver.diver_name ]
    end
    divers_responsible_for.map{ |d| coral_demographics_for_diver(d) }.flatten(1).each do |rep|

      divers_list << [rep.sample_date, rep.field_id, rep.diver.diver_name ]
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
