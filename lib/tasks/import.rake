require "csv"

namespace :import do
  # rake import:all
  desc "Import corals and cover categories from db/SupportData"
  task all: [:corals, :cover_cats, :animals]

  # rake import:divers FILE=db/SupportData/NCRMP_DiverList_2025.csv
  desc "Import divers from a CSV"
  task divers: :environment do
    file = ENV.fetch("FILE")
    CSV.foreach(file, headers: true) do |row|
      diver = Diver.find_or_initialize_by(diver_name: row["DIVER_NAME"])

      diver.diver_number = row["DIVER_NUM"]
      diver.username = row["username"]
      diver.email = row["email"]
      diver.password = (row["password"].presence || row["username"]) if diver.new_record?
      diver.active = (row["active"].upcase == "TRUE")
      diver.role = row["role"]

      new_record = diver.new_record?
      if diver.save(context: :import)
        STDOUT.puts "Imported #{new_record ? "NEW " : ""}diver '#{diver.diver_name}'"
      else
        STDERR.puts "Saving diver '#{diver.diver_name}' failed: #{diver.errors.full_messages.join(", ")}"
      end
    end
  end

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

      new_record = coral.new_record?
      if coral.save
        STDOUT.puts "Imported #{new_record ? "NEW " : ""}coral '#{coral.code}'"
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
      cover_cat.short_code = row["Short Code"]

      new_record = cover_cat.new_record?
      if cover_cat.save
        STDOUT.puts "Imported #{new_record ? "NEW " : ""}cover cat '#{cover_cat.code}'"
      else
        STDERR.puts "Saving cover cat '#{cover_cat.code}' failed: #{cover_cat.errors.full_messages.join(", ")}"
      end
    end
  end

  # rake import:animals FILE=db/SupportData/fish_sppList_with_rank_2025.csv
  desc "Import animals from a CSV"
  task animals: :environment do
    file = ENV.fetch("FILE", Rails.root.join("db/SupportData/fish_sppList_with_rank_2025.csv"))
    CSV.foreach(file, headers: true) do |row|
      animal = Animal.find_or_initialize_by(species_code: row["SPP_CD"])

      animal.species_code = row["SPP_CD"]
      animal.scientific_name = row["sci_name"]
      animal.common_name = row["common_name"]
      animal.max_size = row["max_size"]
      animal.min_size = row["min_size"]
      animal.max_number = row["max_num"]
      animal.rank = row["rank"]

      new_record = animal.new_record?
      if animal.save
        STDOUT.puts "Imported #{new_record ? "NEW " : ""}animal '#{animal.species_code}'"
      else
        STDERR.puts "Saving animal '#{animal.species_code}' failed: #{animal.errors.full_messages.join(", ")}"
      end
    end
  end
end
