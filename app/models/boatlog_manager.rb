class BoatlogManager < ActiveRecord::Base
  has_many  :samples
  has_one   :diver
  has_many  :benthic_covers
  has_many  :coral_demographics
  has_many  :boat_logs

  def agency_name
    "#{agency}/#{lastname}"
  end

  validates :agency,        :presence => true
  validates :firstname,     :presence => true
  validates :lastname,      :presence => true

  def divers_responsible_for
    sample_divers = samples.map { |sample| sample.diver_samples.primary }.flatten.map { |diver_sample| diver_sample.diver }
    lpi_divers = benthic_covers.map { |benthic_cover| benthic_cover.diver }
    demo_divers = coral_demographics.map { |coral_demographic| coral_demographic.diver }
    (sample_divers + lpi_divers + demo_divers).uniq
  end

  def benthic_covers_for_diver(diver)
    benthic_covers.where(:diver => diver)
  end

  def benthic_covers_count_for_diver(diver)
    benthic_covers_for_diver(diver).count
  end



end
