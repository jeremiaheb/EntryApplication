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
    sample_divers = samples.map { |sample| sample.diver_samples.primary }.flatten.map { |diver_sample| diver_sample.diver }
    lpi_divers = benthic_covers.map { |benthic_cover| benthic_cover.diver }
    demo_divers = coral_demographics.map { |coral_demographic| coral_demographic.diver }
    (sample_divers + lpi_divers + demo_divers).uniq
  end

  def benthic_covers_for_diver(diver)
    benthic_covers.where(:diver_id => diver.id)
  end

  def benthic_covers_count_for_diver(diver)
    benthic_covers_for_diver(diver).count
  end

  def coral_demographics_for_diver(diver)
    coral_demographics.where(:diver_id => diver.id)
  end

  def coral_demographics_count_for_diver(diver)
    coral_demographics_for_diver(diver).count
  end

  def samples_for_diver(diver)
    samples.joins(:diver_samples).where('diver_samples.primary_diver = ?', true).where('diver_samples.diver_id = ?', diver.id)
  end

  def samples_count_for_diver(diver)
    samples_for_diver(diver).count
  end
end
