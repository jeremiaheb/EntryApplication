require "csv"

namespace :import do
  # rake import:all
  desc "Import corals and cover categories from db/SupportData"
  task all: [:corals, :cover_cats]

  # rake import:corals FILE=db/SupportData/CoralSpecies_July2025.csv
  desc "Import corals from a CSV"
  task corals: :environment do
    file = ENV.fetch("FILE", Rails.root.join("db/SupportData/CoralSpecies_July2025.csv"))
    CSV.foreach(file, headers: true) do |row|
      coral = Coral.find_or_initialize_by(code: row["Code"])

      coral.scientific_name = row["ScientificName"]
      coral.common_name = row["CommonName"]
      coral.short_code = row["Short Code"]
      coral.rank = row["Rank"]

      if coral.save
        STDOUT.puts "Imported coral '#{coral.code}'"
      else
        STDERR.puts "Saving coral '#{coral.code}' failed: #{coral.errors.full_messages.join(", ")}"
      end
    end
  end

  # rake import:cover_cats FILE=db/SupportData/LPISpecies_July2025.csv
  desc "Import cover cats from a CSV"
  task cover_cats: :environment do
    file = ENV.fetch("FILE", Rails.root.join("db/SupportData/LPISpecies_July2025.csv"))
    CSV.foreach(file, headers: true) do |row|
      cover_cat = CoverCat.find_or_initialize_by(code: row["Code"])

      cover_cat.name = row["ScientificName"]
      cover_cat.common = row["CommonName"]
      cover_cat.proofing_code = row["Proofing Code"]
      cover_cat.rank = row["Rank"]

      if cover_cat.save
        STDOUT.puts "Imported cover cat '#{cover_cat.code}'"
      else
        STDERR.puts "Saving cover cat '#{cover_cat.code}' failed: #{cover_cat.errors.full_messages.join(", ")}"
      end
    end
  end
end
